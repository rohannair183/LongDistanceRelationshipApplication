//
//  MyStatusCard.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-07-22.
//

import SwiftUI
import EmojiPicker
import PopupView

struct MyStatusCard: View {
    @ObservedObject var appState: AppState
    @State var selectedEmoji: Emoji?
    @State var displayEmojiPicker: Bool = false
    var status: StatusModel
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("My Status").font(currentTheme.cardBody.bold()).padding([.top, .leading])
                Spacer()
                Button{
                    displayEmojiPicker.toggle()
                }label:{
                    Text("Edit").font(currentTheme.caption).foregroundColor(.blue)
                    
                }
            }
            HStack{
                Text(status.emoji)
            }.font(.system(size: 50)).padding(.bottom, 1)
            
            Text(status.note).font(currentTheme.caption).padding([.bottom])
        }.frame(maxWidth: 175).padding([.leading, .trailing]).background(currentTheme.backgroundColor.opacity(0.7)).cornerRadius(18).opacity(0.7)
            .lineLimit(0)
            .sheet(isPresented: $displayEmojiPicker) {
                VStack {
                    EditStatusCard(appState: appState, displayStatusChangeScreen: $displayEmojiPicker, selectedEmoji: selectedEmoji, status: status)
                }
            }
    }
}



struct MyStatusCard_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            MyStatusCard(appState: AppState(), status: StatusModel.exampleStatus)
            PartnerStatusCard(status: StatusModel.exampleStatus)
        }.padding()
        
    }
}
