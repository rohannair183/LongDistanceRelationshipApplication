//
//  EmptyUserStatusCard.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-07-26.
//

import SwiftUI

struct EmptyUserStatusCard: View {
    @ObservedObject var appState: AppState
    @State var showEditStatus: Bool = false
    var body: some View {
        VStack{
            Button{
                showEditStatus.toggle()
            }label: {
                Text("Add your status")
            }
        }.frame(width: 175, height: 140)
         .background(currentTheme.backgroundColor.opacity(0.7)).cornerRadius(18).opacity(0.7)
         .sheet(isPresented: $showEditStatus){
             EditStatusCard(appState: appState, displayStatusChangeScreen: $showEditStatus, status: StatusModel.exampleStatus)
         }
    }
}

struct EmptyUserStatusCard_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            EmptyUserStatusCard(appState: AppState())
            EmptyUserStatusCard(appState: AppState())
        }
    }
}
