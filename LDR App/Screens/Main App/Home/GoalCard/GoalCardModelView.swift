//
//  GoalCardModelView.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-07-01.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore

class GoalCardModelView: ObservableObject{
    
    func addCard (goalCard:GoalCardModel, appState:AppState){
        let userCardRef = db.document("Users/\(appState.user[0].email.lowercased())/Cards/\(goalCard.id)")
        let partnerCardRef = db.document("Users/\(appState.userPartner[0].email.lowercased())/Cards/\(goalCard.id)")
        
        do{
            try userCardRef.setData(from: goalCard)
            try partnerCardRef.setData(from: goalCard)
            let userCompleted = goalCard.userCompleted
            let partnerCompleted = goalCard.partnerCompleted
            partnerCardRef.updateData(["user completed": partnerCompleted])
            partnerCardRef.updateData(["partner completed": userCompleted])
        } catch {
            print("\(error.localizedDescription)")
        }
    }

    func deleteCard (goalCard: GoalCardModel, appState: AppState){
        let userCardRef = db.document("Users/\(appState.user[0].email.lowercased())/Cards/\(goalCard.id)")
        let partnerCardRef = db.document("Users/\(appState.userPartner[0].email.lowercased())/Cards/\(goalCard.id)")
        
        userCardRef.delete(){ err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
        partnerCardRef.delete(){ err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
        
    }
}
