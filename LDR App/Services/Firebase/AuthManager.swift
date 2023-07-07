//
//  RegistrationService.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-18.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
let db = Firestore.firestore()

class AuthManager: ObservableObject{
    @Published var users: [User] = []
    
    func registerUser (fName:String, lName:String, email:String, password:String,  returnUser: @escaping (User?) -> Void){
        Auth.auth().createUser(withEmail:email, password: password){ result, error in
            if error != nil{
                print(error!.localizedDescription)
            }else{
                let user:User? = User(firstName: fName, lastName: lName, email: email, partnerJoined: false)
                if let user{
                    do {
                        try db.collection("Users").document(user.email.lowercased()).setData(from: user)
                    } catch let error {
                        print("Error writing city to Firestore: \(error)")
                    }
                }
                returnUser(user)
                print(result!.description)
            }
        }
    }
    
    func loginUser (appState: AppState, email: String, password: String, returnUser: @escaping (User?) -> Void){
        var user: User? = nil
        Auth.auth().signIn(withEmail:email.lowercased(), password: password){ result, error in
            if error != nil{
                print(error!.localizedDescription)
            }else{
                let docRef = db.collection("Users").document(email.lowercased())
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        do{
                            user = try document.data(as:User.self)
                            returnUser(user)
                            
                            db.collection("Users").whereField("id", isEqualTo: user!.partnerId ?? "")
                                .getDocuments() { (querySnapshot, err) in
                                    if  querySnapshot!.documents.count == 1{
                                        let partner = querySnapshot!.documents[0]
                                        do{
                                            try appState.userPartner.append(partner.data(as: User.self))
                                            if let user{
                                                appState.setAppState(appState: appState, user: user)
                                            }
                                        }catch {
                                            print("Something went wrong with adding your partner to your account.")
                                        }
                                        print("Your partner:  => \(appState.userPartner[0].firstName)")
                                    }else{
                                        if let user{
                                            appState.setAppState(appState: appState, user: user)

                                        }
                                    }
                                }
                            print("Logged in user: \(user!.firstName)")
                        }catch let error {
                            print("Error in logging in: \(error.localizedDescription)")
                        }
                        
                    } else {
                        print("Document does not exist")
                    }
                }
                
                print(result!.description)
            }
        }
    }
    
    func createJoinCode(appState:AppState) -> Int{
        let user = appState.user[0]
        //        print("Join code: \(user.joinCode)")
        if let joinCode = user.joinCode{
            return Int(exactly: joinCode)!
        }else{
            let joinCode = Int.random(in: 100000..<999999)
            user.joinCode = joinCode
            
            let userRef = db.collection("Users").document(user.email.lowercased())
            userRef.updateData(["join code": joinCode]){ err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
            return joinCode
        }
    }
    func connectWithPartner(code:Int, appState:AppState){
        let userRef = db.collection("Users").document(appState.user[0].email.lowercased())
        db.collection("Users").whereField("join code", isEqualTo: code)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    if querySnapshot!.documents.isEmpty{
                        print("Invalid User Code!!!!")
                    }
                    if  querySnapshot!.documents.count == 1{
                        let partner = querySnapshot!.documents[0]
                        do{
                            try appState.userPartner.append(partner.data(as: User.self))
                            let partnerRef = db.collection("Users").document(appState.userPartner[0].email.lowercased())
                            appState.appStage = .waitingForUser
                            
                            if appState.userPartner[0].partnerId != nil{
                                partnerRef.updateData(["partner joined": true])
                                appState.user[0].partnerJoined = true
                                appState.appStage = .main
                            }
                            appState.user[0].partnerId = appState.userPartner[0].id
                            try userRef.setData(from: appState.user[0])
                        }catch {
                            print("Something went wrong with adding your partner to your account.")
                        }
                        print("Your partner:  => \(appState.userPartner[0].firstName)")
                        
                    }else{
                        for document in querySnapshot!.documents {
                            print("\(document.documentID) => \(document.data())")
                        }
                    }
                }
            }
        
    }
    
}
