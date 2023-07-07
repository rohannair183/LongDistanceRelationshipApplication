//
//  InviteCodeScreen.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-22.
//

import SwiftUI

struct InviteCodeDisplayScreen: View {
    var authManager:AuthManager = AuthManager()
    @ObservedObject var appState:AppState
    @State var PartnerInviteCode:String = ""
    
    var body: some View {
        let code = authManager.createJoinCode(appState: appState)
        
        VStack {
            Spacer()
            
            
            InviteCodeBox(code: code)
            
            Spacer()
            NavigationLink(destination: CodeInputScreen(appState: appState)) {
                Text("Continue")
            }.buttonStyle(PrimaryButton())
            Spacer()
            
            
        }.frame(maxWidth: 300)
        .navigationBarBackButtonHidden()
    }
}

struct InviteCodeScreen_Previews: PreviewProvider {
    static var previews: some View {
        InviteCodeDisplayScreen(appState: AppState())
    }
}
