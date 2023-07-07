//
//  OnboardingPages.swift
//  LDR App 
//
//  Created by Rohan Nair on 2023-06-14.
//

import Foundation

struct OnboardingPageModel: Identifiable{
    let id = UUID()
    let name: String
    let description: String
    let imageURL: String
    let tag: Int
    
    static var samplePage = OnboardingPageModel(name: "Sample Page", description: "Meant for debuggin purposes", imageURL: "Onboarding1", tag: 3)
    
    static var realPages: [OnboardingPageModel] = [
        OnboardingPageModel(name: "Sample Page 1", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi.", imageURL: "Onboarding1", tag: 1),
        OnboardingPageModel(name: "Sample Page 2", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi.", imageURL: "Onboarding2", tag: 2),
        OnboardingPageModel(name: "Sample Page 3", description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi.", imageURL: "Onboarding3", tag: 3)
    
    ]
    
    static var realPage = OnboardingPageModel(name: "Welcome!", description: "Get started with a few simple steps!", imageURL: "Onboarding3", tag: 1)
}
