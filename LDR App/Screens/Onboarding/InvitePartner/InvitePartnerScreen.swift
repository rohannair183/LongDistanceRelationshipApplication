//
//  InvitePartnerScreen.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-20.
//

import SwiftUI

struct InvitePartnerScreen: View {
    @State var partnerJoined: Bool? = nil
    @State var joinCode = ""
    @StateObject var appState:AppState
    
    var body: some View {
        NavigationView{
            InviteCodeDisplayScreen(appState:appState)
        }
        
    }
}

struct InvitePartnerScreen_Previews: PreviewProvider {
    static var previews: some View {
        InvitePartnerScreen(appState:AppState())
    }
}
