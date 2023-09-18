//
//  GoalCard.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-26.
//

import SwiftUI
import SDWebImageSwiftUI

struct GoalCardView: View {
    @ObservedObject var appState: AppState
    let competetiveGoalCard:GoalCardModel
    var body: some View {
        VStack {
            VStack(alignment:.leading){
                HStack{
                    Text(competetiveGoalCard.title)
                        .font(currentTheme.smallTitle)
                        .foregroundColor(currentTheme.bodyTextColor)
                        .frame(width: 300, alignment: .leading)
                        .multilineTextAlignment(.center)
                        .lineLimit(0)
                }
                //
                Text(competetiveGoalCard.competitionMode ? "Competetion Goal":"Collaboration Goal").font(currentTheme.cardBody).foregroundColor(Color.gray)
                
                if competetiveGoalCard.competitionMode{
                    HStack(spacing: 10){
                        ProfilePictureView(url: appState.user[0].profileURL)
                        VStack(alignment:.leading, spacing: 5){
                            Text(appState.user[0].firstName).font(currentTheme.body)
                                .foregroundColor(currentTheme.bodyTextColor)
                            ProgressView(value: competetiveGoalCard.userCompleted, total: competetiveGoalCard.frequency.rawValue).frame(maxWidth: 250)
                            
                        }
                    }
                    
                    HStack(alignment: .center){
                        //                        Image("Placeholder")
                        //                            .resizable()
                        //                            .frame(width: 40, height:40)
                        //                            .clipShape(Circle())
                        ProfilePictureView(url: appState.userPartner[0].profileURL)
                        
                        VStack(alignment:.leading, spacing: 5){
                            Text(appState.userPartner[0].firstName).font(currentTheme.body)
                                .foregroundColor(currentTheme.bodyTextColor)
                            ProgressView(value: competetiveGoalCard.partnerCompleted, total: competetiveGoalCard.frequency.rawValue).frame(maxWidth: 250)
                            
                        }
                    }
                }else{
                    HStack(alignment: .center, spacing: 10){
                        //                        Image("Placeholder")
                        //                        image.frame(width: 40, height:40)
                        //                        image.clipShape(Circle())
                        HStack(spacing: -10){
                            ProfilePictureView(url: appState.user[0].profileURL)
                            ProfilePictureView(url: appState.userPartner[0].profileURL)
                        }.frame(maxWidth: 80)
                        
                        
                        VStack(alignment:.leading){
                            ProgressView(value: competetiveGoalCard.userCompleted, total: competetiveGoalCard.frequency.rawValue).frame(maxWidth: 250)
                            
                        }
                    }
                }
            }
        }.padding([.leading, .trailing]).frame(width: 350, height: competetiveGoalCard.competitionMode ? 175: 125).background(currentTheme.secondaryColor.opacity(0.25)).cornerRadius(18)
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
