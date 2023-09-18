//
//  EmptyPartnerStatusCard.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-07-29.
//

import SwiftUI

struct EmptyPartnerStatusCard: View {
    @ObservedObject var appState: AppState
    var body: some View {
        VStack{
            Text("\(appState.userPartner[0].firstName)'s status will show up here once they update it!").font(currentTheme.body).padding()
        }.frame(width: 175, height: 140)
            .background(.blue).cornerRadius(18).opacity(0.7)
    }
}

struct EmptyPartnerStatusCard_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPartnerStatusCard(appState: AppState())
    }
}
