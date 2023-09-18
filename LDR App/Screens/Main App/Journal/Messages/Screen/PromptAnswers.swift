//
//  PromptAnswers.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-08-15.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class MessageViewModel: ObservableObject{
    @Published var messages: [MessageModel] = [MessageModel]()
    
    func sendMessage(appState: AppState, message: MessageModel){
        let formatDate = Calendar.current.startOfDay(for: message.date)
        let userMessagesRef = db.document("Users/\(appState.user[0].email.lowercased())/Prompts/\(formatDate)/Messages/\(message.date)")
        let partnerMessageRef = db.document("Users/\(appState.userPartner[0].email.lowercased())/Prompts/\(formatDate)/Messages/\(message.date)")
       
        try? userMessagesRef.setData(from: message.self)
        var partnerMessageModel = message
        partnerMessageModel.sentByUser = false
        try? partnerMessageRef.setData(from: partnerMessageModel.self)
        
        
    }
    
    
}
struct PromptAnswers: View {
    @ObservedObject var appState: AppState
    @State var date: Date
    @State var message: String = ""
    @ObservedObject var messageViewModel: MessageViewModel = MessageViewModel()
    @ObservedObject var dataManager = DataManager()
    var body: some View {
        VStack {
            if dataManager.currentPrompt.isEmpty != true{
                
                Text(dataManager.currentPrompt[0].prompt).font(currentTheme.smallTitle).padding([.leading, .trailing, .bottom], 10)
            }
            ScrollView{
                if dataManager.messages.count != 0{
                    ForEach(dataManager.messages){message in
                        MessageBubble(appState: appState, message: message)
                    }
                }
            }
            Spacer()
            HStack {
                TextField("message", text: $message)
                Button{
                    let messageModel = MessageModel(date: Date.now, sentByUser: true, text: message)
                    messageViewModel.sendMessage(appState: appState, message: messageModel)
                    message = ""
                } label: {
                    Text("Send")
                }
            }.padding().background(Color(uiColor: .systemGray6))
            
        }.onAppear(){
            dataManager.fetchDailyPrompt(appState: appState, date: date)
            dataManager.fetchPromptMessages(appState: appState, date: Calendar.current.startOfDay(for: Date.now))
        }
    }
}

struct PromptAnswers_Previews: PreviewProvider {
    static var previews: some View {
        PromptAnswers(appState: AppState(), date: Date.now)
    }
}
