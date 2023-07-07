//
//  ContentView.swift
//  LDR App no Firebase
//
//  Created by Rohan Nair on 2023-06-12.
//

import SwiftUI


struct OnboardingScreen: View {
    @ObservedObject var appState:AppState
    @State private var pageIndex = 1
    private let pages: [OnboardingPageModel] = OnboardingPageModel.realPages
    private let page: OnboardingPageModel = OnboardingPageModel.realPage
    private let dotApperance = UIPageControl.appearance()
    
    var body: some View {
        NavigationView{
            VStack (){
                TabView(selection: $pageIndex){
                    if !appState.shortOnboarding{
                        ForEach(pages) { page in
                            VStack(spacing: 20) {
                                OnboardingPageModelView(page: page, pageIndex: $pageIndex, appState:appState)
                            }
                            .tag(page.tag)
                        }
                    }else{
                        OnboardingPageModelView(page: page, pageIndex: $pageIndex, appState:appState).tag(1)
                        
                        SignuporLoginScreen(appState: appState).tag(2)
                    }
                }
            }
            .padding()
            .modifier(TabModifierOnboarding())
            
        }
    }
    
}

struct IntroductionScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen(appState: AppState())
        
    }
    
}
