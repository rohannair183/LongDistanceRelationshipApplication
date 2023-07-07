//
//  HavePartner.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-21.
//

import SwiftUI

struct HavePartner: View {
    var authManager:AuthManager = AuthManager()
    @ObservedObject var appState:AppState
    var body: some View {
        VStack{
            Text("Has your Partner already joined the App?").font(currentTheme.largeTitle)
            Spacer()
            Image("Onboarding2")
                .resizable()
                .scaledToFit()
                .background()
                .frame(width: 400, height: 300, alignment: .center)
                .clipped()
                .clipShape(Circle())
            Spacer()
            NavigationLink(destination: InviteCodeDisplayScreen(appState:appState)) {
                Text("Yes").frame(minWidth: 200)
            }.buttonStyle(PrimaryButton())
            NavigationLink(destination: Text("Hi")) {
                Text("No").frame(minWidth: 200)
            }.buttonStyle(PrimaryButton())
            Spacer()
        }.padding()
    }
    
}

struct HavePartner_Previews: PreviewProvider {
    static var previews: some View {
        HavePartner(appState: AppState())
    }
}
