//
//  AllPromptScreen.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-08-30.
//

import SwiftUI

struct AllPromptScreen: View {
    @ObservedObject var appState: AppState
    @ObservedObject var dataManager: DataManager = DataManager()
    var body: some View {
        
        VStack{
            if dataManager.allPrompts.count != 0{
                ForEach(dataManager.allPrompts){prompt in
                    Text(prompt.prompt)
                }
            }else{
                Text("No Previous Journals")
            }
        }.onAppear(){
            dataManager.fetchAllPrompts(appState: appState)
        }
    }
}

struct AllPromptScreen_Previews: PreviewProvider {
    static var previews: some View {
        AllPromptScreen(appState: AppState())
    }
}
