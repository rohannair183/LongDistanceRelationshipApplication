//
//  SignuporLoginScreen.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-20.
//

import SwiftUI

struct SignuporLoginScreen: View {
    @State var shouldSignUp: Bool = true
    @ObservedObject var appState: AppState
    var body: some View {
        
        if  shouldSignUp{
            SignUpScreen(shouldSignup: $shouldSignUp, appState: appState)
        }else{
            LoginScreen(shouldSignup: $shouldSignUp, appState: appState)
        }
        
        
    }
}

struct SignuporLoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        @State var shouldSignUp = true
        SignuporLoginScreen(appState: AppState())
    }
}
