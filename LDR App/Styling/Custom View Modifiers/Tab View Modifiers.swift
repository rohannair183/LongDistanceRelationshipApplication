//
//  ViewModifiers.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-15.
//

import SwiftUI

struct TabModifierOnboarding: ViewModifier{
    @State var currentTheme:Theme = themes[0]
    private let dotApperance = UIPageControl.appearance()

    func body(content: Content) -> some View {
        content
            .animation(.easeInOut, value: 2)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .onAppear{
                dotApperance.currentPageIndicatorTintColor = UIColor(currentTheme.darkColor)
                dotApperance.pageIndicatorTintColor = UIColor(currentTheme.secondaryColor)
            }
            
    }
}
