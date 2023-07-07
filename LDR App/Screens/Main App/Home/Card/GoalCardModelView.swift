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
        let carRef = db.document("Users/\(appState.user[0].email.lowercased())/Cards/\(goalCard.id)")
        do{
            try carRef.setData(from: goalCard)
        } catch {
            
        }
    }
}
