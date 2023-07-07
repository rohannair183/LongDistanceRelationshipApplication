//
//  LocalDatabase.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-07-02.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore



class DataManager: ObservableObject {
    @Environment(\.isPreview) var isPreview
    @Published var Goals: [GoalCardModel] = [GoalCardModel]()
    
    func fetchGoals(appState:AppState){
        if isPreview{
            self.Goals = GoalCardModel.sampleCards
        }else{
            var goals = [GoalCardModel]()
            db.collection("Users/\(appState.user[0].email.lowercased())/Cards")
                .addSnapshotListener{ querySnapshot, error in
                    guard let documents = querySnapshot?.documents else {
                        print("Error fetching documents: \(error!)")
                        return
                    }
                    goals = documents.compactMap { queryDocumentSnapshot -> GoalCardModel? in
                        return try? queryDocumentSnapshot.data(as: GoalCardModel.self)
                    }
                    self.Goals = goals
                    print(self.Goals)

                }
        }
    }
}
