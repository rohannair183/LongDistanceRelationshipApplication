//
//  LoginScreen.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-20.
//

import SwiftUI
import Firebase

struct LoginScreen: View {
    @State var email = ""
    @State var password = ""
    
    
    @Binding var shouldSignup: Bool
    @StateObject var authManager = AuthManager()
    
    @ObservedObject var appState:AppState
    var body: some View {
        VStack {
            
            TextInputField(text: $email, placeHolder: "Email", keyboardType: .emailAddress, sfSymbol: "envelope.fill").padding()
            SecureTextInputField(text: $password, placeHolder: "Password", keyboardType: .default, sfSymbol: "lock.fill").padding()
            
            Button("Login"){
                authManager.loginUser(appState: appState, email: email, password: password)
            }.buttonStyle(PrimaryButton())
            
            Button("Don't have an account? Sign Up"){
                withAnimation(.spring()) {
                    shouldSignup = true
                }
            }.padding()
        }.padding()
        
        
        
    }
}
struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        @State var shouldSignUp = true

        LoginScreen(shouldSignup: $shouldSignUp, appState:AppState())
    }
}
