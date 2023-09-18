//
//  MyStausModelView.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-07-26.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore


class StatusModelView: ObservableObject{
    func changeStatus (status: StatusModel, appState:AppState){
        let userCardRef = db.document("Users/\(appState.user[0].email.lowercased())/Status/\(appState.user[0].firstName)")
        
        do{
            try userCardRef.setData(from: status)
        } catch {
            print("\(error.localizedDescription)")
        }
    }

}
