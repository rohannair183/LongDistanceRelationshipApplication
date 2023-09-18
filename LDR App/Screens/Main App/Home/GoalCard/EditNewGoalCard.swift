//
//  EditNewGoalCard.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-07-08.
//

import SwiftUI

struct EditNewGoalCard: View {
    @ObservedObject var appState: AppState
    @State var userInputs: GoalCardModel
    @Binding var showEditNewGoalCard: Bool
    
    
    var goalCardModelView = GoalCardModelView()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("What goal do you have in mind?", text: $userInputs.title)
                    .frame(maxWidth: .infinity)
                //                    .multilineTextAlignment(.center)
                    .padding(.vertical, 10)
                    .overlay(Rectangle().frame(height: 2).padding(.top, 35))
                    .keyboardType(.default)
                    .foregroundColor(Color.gray)
                    .padding()
                Form{
                    Section{
                        Picker("Frequency:", selection: $userInputs.frequency){
                            ForEach(GoalCardModel.Frequency.allCases, id: \.self.rawValue){option in
                                Text(String(describing: option)).tag(option)
                            }
                        }
                        
                        Picker("Unit:", selection: $userInputs.unit){
                            ForEach(GoalCardModel.Unit.allCases, id: \.self.rawValue){option in
                                Text(String(describing: option)).tag(option)
                            }
                        }
                    }
                    
                    Section{
                        DatePicker(selection: $userInputs.dateStart, in: Date.now..., displayedComponents: .date) {
                                       Text("Select day to start")
                                   }
                        DatePicker(selection: $userInputs.dateEnd, in: Date.now..., displayedComponents: .date) {
                                       Text("Select day to end")
                                   }
                    }
                    
                    Section{
                        Toggle("Competition Mode", isOn: $userInputs.competitionMode)
                    }
                }
            }.toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button{
                        showEditNewGoalCard = false
                    }label:{
                        Text("Cancel").foregroundColor(Color.red)
                    }
                }
                
                ToolbarItem(placement: .confirmationAction){
                    Button{
                        if userInputs.title.isEmpty != true{
                            goalCardModelView.addCard(goalCard: userInputs, appState: appState)
                            showEditNewGoalCard = false
                        }else{
                            //Show Error
                        }
                        
                        
                    }label:{
                        Text("Save")
                    }
                }
                
            }
        }
        
    }
}

struct EditNewGoalCard_Previews: PreviewProvider {
    static var previews: some View {
        @State var inputs = GoalCardModel(title: "Title of the goal", competitionMode: false, frequency: .oneTime, unit: .perDay, userCompleted: 0, partnerCompleted: 0, dateStart: Date.now, dateEnd: Calendar.current.date(byAdding: .month, value: 1, to: Date.now)!)
        @State var inputs2: GoalCardModel? = GoalCardModel(title: "Title of the goal", competitionMode: false, frequency: .oneTime, unit: .perDay, userCompleted: 0, partnerCompleted: 0, dateStart: Date.now, dateEnd: Calendar.current.date(byAdding: .month, value: 1, to: Date.now)!)
        EditNewGoalCard(appState: AppState(), userInputs: inputs, showEditNewGoalCard: .constant(true))
    }
}
