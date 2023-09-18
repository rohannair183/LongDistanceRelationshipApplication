//
//  MainJournal.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-07-31.
//

import SwiftUI

struct Message{
    var message: String
    var name: String
}
enum JournalTypes: String, CaseIterable{
    case daily = "Daily Journal"
    case freestyle = "Freestyle"
}
struct MainJournal: View {
    @State var uiTabarController: UITabBarController?
    
    @ObservedObject var appState: AppState
    @State var journalType: JournalTypes = .daily
    @ObservedObject var dataManager = DataManager()
    @State var displayedDate = Date.now
    
    var body: some View {
        NavigationStack{
            VStack {
                JournalHeader(appState: appState, date: displayedDate)
                Picker("Journal Type", selection: $journalType){
                    ForEach(JournalTypes.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }.pickerStyle(.segmented).padding()
                Spacer()
                if journalType == .daily{
                    NavigationLink{
                        PromptAnswers(appState: appState, date: displayedDate)
                            .toolbar(.hidden, for: .tabBar)
                    } label: {
                        Text("Answer Question")
                    }.buttonStyle(PrimaryButton())
                        
                    
                    
                }else if journalType == .freestyle{
                    Text("Freestyle :)")
                }
                Spacer()
            }
        }
    }
    
    
    
}

struct MainJournal_Previews: PreviewProvider {
    static var previews: some View {
        MainJournal(appState: AppState())
    }
}
