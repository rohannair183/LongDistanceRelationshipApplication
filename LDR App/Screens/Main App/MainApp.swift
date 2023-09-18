//
//  MainApp.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-26.
//

import SwiftUI

struct MainApp: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        
        TabView{
            HomeScreen(appState: appState)
                .tabItem{
                    Label("Home", systemImage: "house")
                }
            MainJournal(appState: appState)
                .tabItem{
                    Label("Journal", systemImage: "doc.plaintext")
                }
            Text("Album")
                .tabItem{
                    Label("Album", systemImage: "photo")
                }
            MainSettings(appState: appState)
                .tabItem{
                    Label("Settings", systemImage: "gearshape")
                }
        }
        
    }
}

struct MainApp_Previews: PreviewProvider {
    static var previews: some View {
        MainApp(appState: AppState())
    }
}
