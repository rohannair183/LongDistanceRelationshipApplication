//
//  OnboardingPageModelView.swift
//  LDR App no Firebase
//
//  Created by Rohan Nair on 2023-06-14.
//

import SwiftUI

struct OnboardingPageModelView: View {
    var page:OnboardingPageModel
    @Binding var pageIndex: Int
    @ObservedObject var appState:AppState
    var body: some View {
            VStack(){
                Image("\(page.imageURL)")
                    .resizable()
                    .scaledToFit()
                    .background()
                
                
                Text(page.name).font(currentTheme.mediumTitle)
                    .padding()
                Text(page.description)
                    .font(currentTheme.body)
                Spacer()
                if page.tag == 3{
                    NavigationLink(destination:SignuporLoginScreen(appState:appState)){
                        Text("Get Started")
                    }
                    .buttonStyle(PrimaryButton())
                }else{
                    Button(appState.shortOnboarding ? "Get Started":"Next"){
                        withAnimation(.easeInOut(duration: 4)) {
                            incrementPage()
                        }
                    }
                    .buttonStyle(PrimaryButton())
                }
                Spacer()
                
            }
        }
    func incrementPage (){
        pageIndex += 1
    }
}

struct OnboardingPageModelView_Previews: PreviewProvider {
    static var previews: some View {
        @State var testPageIndex = 3
        OnboardingPageModelView(page: OnboardingPageModel.samplePage, pageIndex: $testPageIndex, appState: AppState())
    }
}
