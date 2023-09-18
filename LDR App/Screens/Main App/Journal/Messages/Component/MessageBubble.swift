//
//  MessageBubble.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-08-11.
//

import SwiftUI

struct MessageBubble: View {
    @State var appState: AppState
    @State var message: MessageModel
    var body: some View {
        VStack {
            HStack{
                if message.sentByUser{
                    Spacer()
                    Text(message.text).padding().font(currentTheme.cardBody).background(message.sentByUser ? currentTheme.secondaryColor : currentTheme.contrastBackground).foregroundColor(currentTheme.bodyTextColor).clipShape(RoundedRectangle(cornerRadius: 20.0))
                        .overlay(alignment: message.sentByUser ? .bottomTrailing : .bottomLeading){
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundColor(message.sentByUser ? currentTheme.secondaryColor : currentTheme.contrastBackground)
                                .offset(x: 0, y: 5)
                                .rotationEffect(Angle(degrees: message.sentByUser ? -45 : 45))
                        }
                    ProfilePictureView(url: appState.user[0].profileURL)
                    
                }else{
                    ProfilePictureView(url: appState.userPartner[0].profileURL)
                    Text(message.text).padding().font(currentTheme.cardBody).background(message.sentByUser ? currentTheme.secondaryColor : currentTheme.contrastBackground).foregroundColor(currentTheme.bodyTextColor).clipShape(RoundedRectangle(cornerRadius: 20.0))
                        .overlay(alignment: message.sentByUser ? .bottomTrailing : .bottomLeading){
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundColor(message.sentByUser ? currentTheme.secondaryColor : currentTheme.contrastBackground)
                                .offset(x: 0, y: 5)
                                .rotationEffect(Angle(degrees: message.sentByUser ? -45 : 45))
                        }
                    Spacer()
                }
            }
        }.padding([.leading, .trailing])
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
//                Spacer()
                MessageBubble(appState: AppState(), message: MessageModel.messages[0])
            }
            HStack {
                MessageBubble(appState: AppState(), message: MessageModel.messages[1])
//                Spacer()
            }
        }
    }
}
