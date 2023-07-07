//
//  AppState.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-21.
//

import SwiftUI

enum appStages{
    case auth
    case invitation
    case waitingForUser
    case main
}
class AppState: ObservableObject{
    @Environment(\.isPreview) var isPreview
    
    @Published var appStage: appStages = .auth
    @Published var user: [User] = [User]()
    @Published var userPartner: [User] = [User]()
    
    init() {
        if isPreview{
            self.user = [User(firstName: "Rohan", lastName: "Nair", email: "rohannair183@gmail.com", partnerJoined: true)]
            self.userPartner = [User(firstName: "Chrisandra", lastName: "Vaz", email: "chrisvaz@gmail.com", partnerJoined: true)]
        }
    }
    
    func setAppState(appState: AppState, user:User){
        if user.partnerJoined{
            appState.appStage = .main
        }else if user.partnerId == nil{
            appState.appStage = .invitation
        }else if user.partnerId != nil{
            appState.appStage = .waitingForUser
        }
        
    }
    
    // Short vs long-onbaording for testing
    @Published var shortOnboarding = true
    
    
    
}
