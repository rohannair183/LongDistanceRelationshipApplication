//
//  GoalCard.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-26.
//

import SwiftUI

struct GoalCardView: View {
    @ObservedObject var appState: AppState
    let competetiveGoalCard:GoalCardModel
    var body: some View {
        VStack {
            VStack(alignment:.leading){
                Text(competetiveGoalCard.title)
                    .font(currentTheme.smallTitle)
                Text(competetiveGoalCard.competitionMode ? "COMPETITION MODE":"").font(currentTheme.caption).foregroundColor(Color.gray)
                HStack(alignment: .center, spacing: 10){
                    Image("Placeholder")
                        .resizable()
                        .frame(width: 40, height:40)
                        .clipShape(Circle())
                    
                    VStack(alignment:.leading){
                        Text(appState.user[0].firstName).font(currentTheme.body)
                        ProgressView(value: competetiveGoalCard.userCompleted, total: competetiveGoalCard.frequency.rawValue).frame(maxWidth: 250)
                        
                    }
                }
                if competetiveGoalCard.competitionMode{
                    HStack(alignment: .center, spacing: 10){
                        Image("Placeholder")
                            .resizable()
                            .frame(width: 40, height:40)
                            .clipShape(Circle())
                        
                        VStack(alignment:.leading){
                            Text(appState.userPartner[0].firstName).font(currentTheme.body)
                            ProgressView(value: competetiveGoalCard.partnerCompleted, total: competetiveGoalCard.frequency.rawValue).frame(maxWidth: 250)
                            
                        }
                    }
                }
            }
        }.frame(width: 350, height: competetiveGoalCard.competitionMode ? 175: 125).background(currentTheme.secondaryColor.opacity(0.25)).cornerRadius(18)
    }
}

struct GoalCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GoalCardView(appState:AppState(), competetiveGoalCard: GoalCardModel.sampleCards[1])
            //0, 1 competetive
            //2 collabrative
        }
    }
}
