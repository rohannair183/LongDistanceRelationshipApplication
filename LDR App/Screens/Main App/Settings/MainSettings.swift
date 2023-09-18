//
//  MainSettings.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-08-07.
//

import SwiftUI

struct MainSettings: View {
    @State var profilePic: UIImage?
    @ObservedObject var storageManager = StorageManager()
    @ObservedObject var appState: AppState
    var body: some View {
        
        ZStack {
            VStack{
                MainProfilePickerView(finalImage: $profilePic)
                    .onChange(of: profilePic){newImage in
                        storageManager.saveProfile(appState: appState, image: profilePic!)
                    }
            }
            
            if appState.isLoading{
                Color.gray.opacity(0.5).ignoresSafeArea()
                Loading()
                    .frame(width: .infinity, height: .infinity)
                    .ignoresSafeArea()
                
            }
        }
        
        
    }
}

struct MainSettings_Previews: PreviewProvider {
    static var previews: some View {
        MainSettings(appState: AppState())
    }
}
