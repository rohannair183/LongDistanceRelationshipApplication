//
//  ProfilePicturePickerScreen.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-07-19.
//
import PhotosUI
import SwiftUI

struct ProfilePicturePickerScreen: View {
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    var body: some View {
        VStack {
            Button{
                
            }label: {
                if let avatarImage {
                    avatarImage
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                    
                }else{
                    Image("no-profile-picture")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 150)
                }
            }
            PhotosPicker("Select avatar", selection: $avatarItem, matching: .images)
            
//            if let avatarImage {
//                avatarImage
//                    .resizable()
//                    .frame(width: 50, height: 50)
//                    .clipShape(Circle())
//                
//            }
        }
        .onChange(of: avatarItem) { _ in
            Task {
                if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        avatarImage = Image(uiImage: uiImage)
                        return
                    }
                }
                
                print("Failed")
            }
        }
    }
}

struct ProfilePicturePickerScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicturePickerScreen()
    }
}

