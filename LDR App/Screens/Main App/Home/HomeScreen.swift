//
//  HomeScreen.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-27.
//

import SwiftUI
import SwipeActions

struct HomeScreen: View {
    @ObservedObject var goalCardModelView = GoalCardModelView()
    @ObservedObject var appState: AppState
    @ObservedObject var dataManager = DataManager()
    @State private var showAddNewGoalCard = false
    var body: some View {
        
        NavigationView
            {
                ScrollView{
                    HStack {
                        Text("Goals").font(currentTheme.mediumTitle)
                        Spacer()
                        Button{
                            showAddNewGoalCard.toggle()
                        }label: {
                            Label("", systemImage: "plus").foregroundColor(.blue)
                        }
                        
                    }.padding([.leading, .trailing], 30)
                        .sheet(isPresented: $showAddNewGoalCard){
                            if #available(iOS 16.4, *) {
                                AddNewGoalCard(appState: appState, showAddNewGoalCard: $showAddNewGoalCard) .presentationCornerRadius(21)
                            }else {
                                AddNewGoalCard(appState: appState, showAddNewGoalCard: $showAddNewGoalCard)
                            }
                            
                            
                        }
                    
                    VStack {
                        ForEach (dataManager.Goals){card in
                            SwipeView {
                                GoalCardView(appState: appState, competetiveGoalCard: card)
                            } trailingActions: { context in
                                SwipeAction(systemImage: "trash"){
                                    
                                }.foregroundColor(Color.red).background(Color.white)
                            }
                            
                        }.padding()
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }.onAppear(){
                    dataManager.fetchGoals(appState: appState)
                }
            }
        }
    }


struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(appState: AppState())
    }
}
