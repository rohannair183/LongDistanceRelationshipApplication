//
//  MoreInfoGoalView.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-07-15.
//

import SwiftUI

struct MoreInfoGoalView: View {
    var goalCardModelView = GoalCardModelView()
    @ObservedObject var appState: AppState
    @State var goal: GoalCardModel?
    @Binding var showMoreInfoScreen: Bool
    
    @State var showEditGoal: Bool = false
    var body: some View {
        var needToComplete: Int {
            return Int(goal!.frequency.rawValue - goal!.userCompleted)
        }
        VStack{
            if var goal{
                HStack {
                    Text(goal.title).font(currentTheme.mediumTitle)
                }.padding(.bottom)
                Text("You have completed this goal \(Int(goal.userCompleted)) out of \(Int(goal.frequency.rawValue)) times this \(goal.unit.rawValue) complete another \(needToComplete) times this \(goal.unit.rawValue) to earn points.").font(currentTheme.body)
                if needToComplete > 0 && goal.currentTimeInterval!.contains(Date.now){
                    Button{
                        goal.userCompleted += 1
                        goalCardModelView.addCard(goalCard: goal, appState: appState)
                        showMoreInfoScreen = false
                    }label:{
                        Text("I have finished this goal")
                    }.buttonStyle(PrimaryButton()).padding(.top)
                }else if !goal.currentTimeInterval!.contains(Date.now){
                    Text("\(Int((goal.dateStart-Date.now)/1140)) more days to go before this goal starts!").font(currentTheme.smallTitle).padding(.top)
                }else {
                    Text("You have already completed the goal for this \(goal.unit.rawValue). Way to go!").font(currentTheme.smallTitle).padding(.top)
                }
                
                Spacer()
            }
        }.sheet(isPresented: $showEditGoal){
            EditNewGoalCard(appState: appState, userInputs: goal!, showEditNewGoalCard: $showEditGoal)
        }.toolbar{
            
            ToolbarItem(placement: .primaryAction){
                Button{
                    showEditGoal = true
                }label:{
                    Text("Edit")
                }
            }
            ToolbarItem(placement: .primaryAction){
                Button{
                  goalCardModelView.deleteCard(goalCard: goal!, appState: appState)
                    showMoreInfoScreen = false
                }label:{
                    Text("Delete")
                }
            }
            
            
        }.padding()
    }
}

struct MoreInfoGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MoreInfoGoalView(appState: AppState(), goal: GoalCardModel.sampleCards[0], showMoreInfoScreen: .constant(true))
        }
    }
}

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}
