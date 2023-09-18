//
//  Content.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-20.
//

import SwiftUI

struct MainContent: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        if appState.appStage == .auth {
            
            OnboardingScreen(appState:appState)
        }else if appState.appStage == .invitation && appState.userPartner.isEmpty
        {

            InvitePartnerScreen(appState: appState)
            
        }else if appState.appStage == .invitation{
            
            Text("Waiting for your partner to enter your Invite Code!")
        }else if appState.appStage == .main{
            
            MainApp(appState: appState)
                .disabled(appState.isLoading)
        }else if appState.appStage == .loading{
            ProgressView()
        }
        
    }
}

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        let appState: AppState = AppState()
        MainContent(appState: appState)
    }
}
