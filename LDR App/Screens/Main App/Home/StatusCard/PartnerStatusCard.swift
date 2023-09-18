//
//  PartnerStatusCard.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-07-23.
//

import SwiftUI

struct PartnerStatusCard: View {
    @ObservedObject var appState: AppState = AppState()
    var status: StatusModel
    var body: some View {
        VStack(alignment: .center){
            HStack(alignment:.center){
                Spacer()
                Text("\(appState.userPartner[0].firstName)'s Status").font(currentTheme.cardBody.bold()).padding([.top]).lineLimit(0)
                Spacer()
            }
            HStack{
                Text(status.emoji)
            }.font(.system(size: 50)).padding(.bottom, 1)
            
            Text(status.note).font(currentTheme.caption).padding([.bottom])
        }.frame(maxWidth: 175).padding([.leading, .trailing]).background(.blue.opacity(0.5)).cornerRadius(18).opacity(0.7)
    }
}

struct PartnerStatusCard_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            MyStatusCard(appState: AppState(), status: StatusModel.exampleStatus)
            PartnerStatusCard(status: StatusModel.exampleStatus)
        }.padding()
    }
}
