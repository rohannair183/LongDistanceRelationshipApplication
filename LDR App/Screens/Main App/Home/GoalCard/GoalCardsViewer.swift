//
//  CardsViewer.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-07-09.
//

import SwiftUI
import SwipeActions
import PopupView
import BottomSheet

struct GoalCardsViewer: View {
    
    @ObservedObject var goalCardModelView = GoalCardModelView()
    @ObservedObject var appState: AppState
    @ObservedObject var dataManager = DataManager()
    @State var showAddNewGoalCard = false
    @State var showMoreGoalInfo = false
    @State var currentGoalCard: GoalCardModel? = nil
    
    var body: some View {
        ScrollView{
            HStack {
                Text("Goals").font(currentTheme.mediumTitle)
                Spacer()
                Button{
                    if dataManager.Goals.count < 5 {
                        showAddNewGoalCard.toggle()
                    }
                }label: {
                    Label("", systemImage: "plus").foregroundColor(.blue)
                }
            }.padding([.leading, .trailing])
                .sheet(isPresented: $showAddNewGoalCard){
                        AddNewGoalCard(appState: appState, showAddNewGoalCard: $showAddNewGoalCard)
                }
            VStack {
                ForEach (dataManager.Goals){card in
                    SwipeView {
                        VStack {
                            GoalCardView(appState: appState, competetiveGoalCard: card)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    currentGoalCard = card
                                    showMoreGoalInfo = true
                                    print(currentGoalCard ?? "nil")
                                }
                            
                        }
                    }trailingActions: { context in
                        SwipeAction(systemImage: "trash"){
                            goalCardModelView.deleteCard(goalCard: card, appState: appState)
                        }.foregroundColor(Color.red).background(Color.white)
                    }
                }.padding()
            }
            .navigationDestination(isPresented: $showMoreGoalInfo){
                MoreInfoGoalView(appState: appState, goal: currentGoalCard, showMoreInfoScreen: $showMoreGoalInfo)
            }
            .onAppear(){
                dataManager.fetchGoals(appState: appState)
            }
        }
    }
}




struct CardsViewer_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GoalCardsViewer(appState: AppState())
        }
    }
}
