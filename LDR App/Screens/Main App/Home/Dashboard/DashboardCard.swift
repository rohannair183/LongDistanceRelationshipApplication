//
//  DashboardCard.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-07-19.
//

import SwiftUI

struct DashboardCard: View {
    @ObservedObject var appState: AppState
    @ObservedObject var dataManager: DataManager = DataManager()
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text("Good Morning,\n\(appState.user[0].firstName)!")
                    .tracking(1)
                    .font(currentTheme.largeTitle)
                Spacer()
            }
            HStack{
                if dataManager.PartnerStatus.count == 0 && dataManager.UserStatus.count == 0{
                    EmptyUserStatusCard(appState: appState)
                    EmptyPartnerStatusCard(appState: appState)
                }else if dataManager.PartnerStatus.count != 0 && dataManager.UserStatus.count == 0{
                    EmptyUserStatusCard(appState: appState)
                    PartnerStatusCard(appState: appState, status: dataManager.PartnerStatus[0])
                }else if dataManager.PartnerStatus.count == 0 && dataManager.UserStatus.count != 0{
                    MyStatusCard(appState: appState, status: dataManager.UserStatus[0])
                    EmptyPartnerStatusCard(appState: appState)
                }else{
                    MyStatusCard(appState: appState, status: dataManager.UserStatus[0])
                    PartnerStatusCard(appState: appState, status: dataManager.PartnerStatus[0])
                }
            }
        }.onAppear(){
            dataManager.fetchStatus(appState: appState)
        }
    }
}

struct DashboardCard_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView{
            HStack{
                DashboardCard(appState: AppState())
            }.padding()
        }
    }
}
