//
//  HomeScreen.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-27.
//

import SwiftUI
import SwipeActions

struct HomeScreen: View {
    @ObservedObject var appState: AppState
    @ObservedObject var dataManager = DataManager()
    var body: some View {
        NavigationStack {
            ScrollView(.vertical){
                HStack {
                    DashboardCard(appState: appState)
                }.padding()
                GoalCardsViewer(appState: appState)
                    .tracking(1)
            }
        }
        
        
    }
    
}


struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(appState: AppState())
    }
}
