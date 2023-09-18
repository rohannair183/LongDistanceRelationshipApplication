//
//  ProfilePictureStorage.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-08-07.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift


class ProfilePictureStorageManager: ObservableObject {
    func storeProfilePicture(image: UIImage){
        let imageData = image.pngData()!.base64EncodedString(options: .lineLength64Characters)
        print("Image string: ")
        print(imageData)
    }
}
