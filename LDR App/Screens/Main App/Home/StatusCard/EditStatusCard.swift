//
//  EditStatusCard.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-07-23.
//

import SwiftUI
import EmojiPicker

struct EditStatusCard: View {
    @ObservedObject var appState: AppState
    
    @Binding var displayStatusChangeScreen: Bool
    
    @State var selectedEmoji: Emoji?
    @State var displayEmojiPicker: Bool = false
    
    @State var status: StatusModel
    
    var body: some View {
        VStack{
            Button{
                displayEmojiPicker.toggle()
            }label: {
                if let selectedEmoji {
                    VStack{
                        Text("Current Emoji").font(currentTheme.cardBody).foregroundColor(.gray)
                        Text(selectedEmoji.value).font(.system(size: 50))
                    }
                }else{
                    VStack{
                        Text("Select Emoji")
                        Text(status.emoji).font(.system(size: 50))
                    }
                }
            }.frame(width: 100, height: 100).border(.gray).foregroundColor(.gray).padding()
            
            
            TextInputField(text: $status.note, placeHolder: "Please Input a note", keyboardType: .default, sfSymbol: nil).padding()
            
            Button{
                if let selectedEmoji{
                    status.emoji = selectedEmoji.value
                    StatusModelView().changeStatus(status: status, appState: appState)
                    displayStatusChangeScreen.toggle()
                }else{
                    StatusModelView().changeStatus(status: status, appState: appState)
                    displayStatusChangeScreen.toggle()
                }
            }label: {
                Text("Save")
            }.buttonStyle(PrimaryButton()).padding()
        }
         .sheet(isPresented: $displayEmojiPicker) {
            VStack {
                NavigationView {
                    EmojiPickerView(selectedEmoji: $selectedEmoji, selectedColor: .orange)
                        .navigationTitle("Emojis")
                        .navigationBarTitleDisplayMode(.inline)
                        .onDisappear() {
                            print("Dismissed")
                        }
                    
                }
            }
        }
    }
}

struct EditStatusCard_Previews: PreviewProvider {
    static var previews: some View {
        
        EditStatusCard(appState: AppState(), displayStatusChangeScreen: .constant(true), status: StatusModel.exampleStatus)
//        MyStatusCard()
    }
}


func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
