//
//  CodeInputScreen.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-23.
//

import SwiftUI

struct CodeInputScreen: View {
    @ObservedObject var appState: AppState
    @StateObject var authManager = AuthManager()
    @State var resultArray: [String] = Array(repeating:"", count:6)
    var body: some View {
        VStack{
            Text("Enter Code").font(currentTheme.mediumTitle)
            Text("Enter your partner's Invite code").font(currentTheme.smallTitle).padding([.top, .bottom])
            codeInputField(enteredValue: $resultArray).padding(.top, 30)
            Spacer()
            Button("Submit"){
                if let code = Int(resultArray.joined()){
                    authManager.connectWithPartner(code: code, appState: appState)
                }
            }.buttonStyle(PrimaryButton())
            HStack{
                Text("Don't have a partner code?")
                Text("Click here").foregroundColor(Color.gray)
            }
        }
    }
}

struct CodeInputScreen_Previews: PreviewProvider {
    static var previews: some View {
        CodeInputScreen(appState: AppState())
    }
}
