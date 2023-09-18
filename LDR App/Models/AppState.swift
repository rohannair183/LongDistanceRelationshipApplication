//
//  AppState.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-21.
//

import SwiftUI

enum appStages: Codable{
    case auth
    case invitation
    case waitingForUser
    case main
    case loading
}
class AppState: ObservableObject, Codable{
    @Environment(\.isPreview) var isPreview
    
    @Published var appStage: appStages = .auth
    @Published var isLoading: Bool = false
    @Published var user: [User] = [User]()
    @Published var userPartner: [User] = [User]()

    enum CodingKeys: String, CodingKey {
        case appStage
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        appStage = try container.decode(appStages.self, forKey: .appStage)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(appStage, forKey: .appStage)

    }
    
    init() {
        if isPreview{
            self.user = [User(firstName: "John", lastName: "Doe", email: "rohannair183@gmail.com", partnerJoined: true)]
            self.userPartner = [User(firstName: "Emily", lastName: "Vaz", email: "chrisvaz@gmail.com", partnerJoined: true)]
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
