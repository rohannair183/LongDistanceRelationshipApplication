//
//  ContentView.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-12.
//

import SwiftUI
import Firebase

struct SignUpScreen: View {
    @State var email = ""
    @State var password = ""
    @State var fName = ""
    @State var lName = ""
    
    @Binding var shouldSignup: Bool
    
    @StateObject var authManager = AuthManager()
    @State var sucessfulLogin: Bool = false
    
    @ObservedObject var appState:AppState
    
    var body: some View {
        VStack {
            VStack{
                TextInputField(text: $fName, placeHolder: "First Name", keyboardType: .default, sfSymbol: nil)
                TextInputField(text: $lName, placeHolder: "Last Name", keyboardType: .default, sfSymbol: nil)
                Divider().padding()
                TextInputField(text: $email, placeHolder: "Email", keyboardType: .emailAddress, sfSymbol: "envelope.fill")
                SecureTextInputField(text: $password, placeHolder: "Password", keyboardType: .default, sfSymbol: "lock.fill")
            }.padding()
            Button {
                authManager.registerUser(appState: appState, fName: fName, lName: lName, email: email, password: password, returnUser: saveUser)
//                withAnimation(.easeIn){
//                    appState.appStage = .invitation
//                }
                
            }label: {
                Text("Sign up")
                
            }.buttonStyle(PrimaryButton())
            
            Button("Already have an account? Login"){
                withAnimation(.spring()){
                    shouldSignup = false
                }
            }.padding()
        }
        .padding()
    }
    
    func saveUser(user: User?){
        appState.user.append(user!)
        print("User Email: \(appState.user[0].email)")
        
    }
}


struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        @State var shouldSignUp = true
        SignUpScreen(shouldSignup: $shouldSignUp, appState:AppState())
    }
}
