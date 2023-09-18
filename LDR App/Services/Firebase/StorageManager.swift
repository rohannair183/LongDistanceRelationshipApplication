//
//  StorageManager.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-07-17.
//

import SwiftUI
import FirebaseCore
import FirebaseStorage

//Create Storage
let storage = Storage.storage()

// Create a root reference
let storageRef = storage.reference()



class StorageManager: ObservableObject{
    func saveProfile (appState: AppState, image: UIImage){
        appState.isLoading = true
        // Create a reference to "mountains.jpg"
        let profileRef = storageRef.child("\(appState.user[0].id)/ProfilePicture.jpg")
        let data = image.jpegData(compressionQuality: 0.2)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        if let data = data {
            profileRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                }else{
                    profileRef.downloadURL{ url, error in
                        appState.objectWillChange.send()
                        let profileRef = db.collection("Users").document(appState.user[0].email.lowercased())
                        appState.user[0].profileURL = "\(url!)"
                        appState.objectWillChange.send()
                        appState.isLoading = false
                        profileRef.updateData(["profile URL": "\(url!)"]){ err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            } else {
                                print("Profile URL updated")
                            }
                        }
                    }
                }
            }
        }
    }

//    func getProfile (appState: AppState, user: User, callback: @escaping (_ appState: AppState, _ user: User) -> Void){
//        let userProfileRef = storageRef.child("\(appState.user[0].id)/ProfilePicture.jpg")
//        let partnerProfileRef = storageRef.child("\(appState.userPartner[0].id)/ProfilePicture.jpg")
//
//        userProfileRef.downloadURL { url, error in
//            if let error = error {
//                print("error getting profile image: \(error)")
//            } else {
//                appState.userProfilePictureURL = "\( url!)"
//                partnerProfileRef.downloadURL { url, error in
//                    if let error = error {
//                        print("error getting profile image: \(error)")
//                    } else {
//                        appState.userProfilePictureURL = "\( url!)"
//                        callback(appState, user)
//                    }
//                }
//                callback(appState, user)
//            }
//        }
//    }
}
