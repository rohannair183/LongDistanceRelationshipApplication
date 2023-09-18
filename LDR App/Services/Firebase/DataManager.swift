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
import FirebaseFirestoreSwift


class DataManager: ObservableObject {
    @Environment(\.isPreview) var isPreview
    
    @Published var Goals: [GoalCardModel] = [GoalCardModel]()
    @Published var UserStatus: [StatusModel] = [StatusModel]()
    @Published var PartnerStatus: [StatusModel] = [StatusModel]()
    @Published var currentPrompt: [PromptModel] = [PromptModel]()
    @Published var messages: [MessageModel] = [MessageModel]()
    @Published var allPrompts: [PromptModel] = [PromptModel]()
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
                    for index in 0..<goals.count{
                        if let curInterval = goals[index].currentTimeInterval{
                            if curInterval != goals[index].setCurrentTimeInterval{
                                goals[index].userCompleted = 0
                                goals[index].partnerCompleted = 0
                                goals[index].currentTimeInterval = goals[index].setCurrentTimeInterval
                                GoalCardModelView().addCard(goalCard: goals[index], appState: appState)
                            }
                        }else {
                            goals[index].currentTimeInterval = goals[index].setCurrentTimeInterval
                            GoalCardModelView().addCard(goalCard: goals[index], appState: appState)
                            
                        }
                    }
                    self.Goals = goals
                }
        }
    }
    
    func fetchStatus(appState: AppState){
        db.collection("Users/\(appState.user[0].email.lowercased())/Status")
            .addSnapshotListener{ querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                do{
                    if documents.isEmpty != true{
                        self.UserStatus.removeAll()
                        try self.UserStatus.append(documents[0].data(as: StatusModel.self))
                    }
                }catch{
                    print("Error with retreivial of Status")
                }
            }
        
        db.collection("Users/\(appState.userPartner[0].email.lowercased())/Status")
            .addSnapshotListener{ querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                do{
                    if documents.isEmpty != true{
                        self.PartnerStatus.removeAll()
                        try self.PartnerStatus.append(documents[0].data(as: StatusModel.self))
                    }
                }catch{
                    print("Error with retreivial of Status")
                }
            }
    }
    
    func fetchDailyPrompt(appState: AppState, prompt: PromptModel? = nil, date: Date){
        let curDate = Calendar.current.startOfDay(for: date)
        let userCurPromptRef = db.document("Users/\(appState.user[0].email.lowercased())/Prompts/\(curDate)")
        let partnerCurPromptRef = db.document("Users/\(appState.userPartner[0].email.lowercased())/Prompts/\(curDate)")
        
        userCurPromptRef.getDocument { (document, error) in
            if let document = document, document.exists {
                do{
                    self.currentPrompt.removeAll()
                    try self.currentPrompt.append(document.data(as: PromptModel.self))
                }catch{
                    print("Couldn't Retrieve Prompt!")
                }
            } else {
                print("Need new prompt!")
                let collectionRef = db.collection("Users/\(appState.user[0].email.lowercased())/Prompts")
                var index = 0
                collectionRef.order(by: "date", descending: true).limit(to: 1).getDocuments{ (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            index = document.data()["index"] as! Int + 1
                            print("\(document.documentID)'s index => \(index)")
                        }
                        
                        let prompt = PromptModel(index: index, date: curDate, prompt: PROMPTS[index])
                        self.currentPrompt.append(prompt)
                        do{
                            try userCurPromptRef.setData(from: prompt)
                            try partnerCurPromptRef.setData(from: prompt)
                        }catch{
                            print("Couldn't add prompt.")
                        }
                    }
                }
                
            }
        }
    }
    
    func fetchPromptMessages(appState: AppState, date: Date){
        let curDate = Calendar.current.startOfDay(for: date)
        let userMessages = db.collection("Users/\(appState.user[0].email.lowercased())/Prompts/\(curDate)/Messages")
        if isPreview != true{
            db.collection("Users/\(appState.user[0].email.lowercased())/Prompts/\(curDate)/Messages")
                .addSnapshotListener{ querySnapshot, error in
                    guard let documents = querySnapshot?.documents else {
                        print("Error fetching documents: \(error!)")
                        return
                    }
                    
                    let messages = documents.compactMap { queryDocumentSnapshot -> MessageModel? in
                        return try? queryDocumentSnapshot.data(as: MessageModel.self)
                    }
                    
                    self.messages = messages
                    
                }
      }
    }
    
    func fetchAllPrompts(appState: AppState){
        db.collection("Users/\(appState.user[0].email.lowercased())/Prompts")
            .addSnapshotListener{ querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                let prompts = documents.compactMap { queryDocumentSnapshot -> PromptModel? in
                    return try? queryDocumentSnapshot.data(as: PromptModel.self)
                }
                print(prompts)
                self.allPrompts = prompts
                
            }

    }
    
}
