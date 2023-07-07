//
//  Theme.swift
//  LDR App 
//
//  Created by Rohan Nair on 2023-06-12.
//

import SwiftUI
//
extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

enum ThemeName {
    case lightMode;
    case darkMode
}

enum Fonts{
    case largeTitle
    case mediumTitle
    case smallTitle
    case body
    case button
    case caption
}

func getFont(name:Fonts) -> Font{
    switch(name){
    case .largeTitle: return Font.custom("SFProDisplay-Bold", size: 30)
        case .mediumTitle: return Font.custom("SFProDisplay-Semibold", size: 28)
        case .smallTitle: return Font.custom("SFProDisplay-Semibold", size: 22)
        case .body: return Font.custom("SFProDisplay-Regular", size: 20)
        case .button: return Font.custom("SFProDisplay-Light", size: 20)
        case .caption: return Font.custom("SFProDisplay-Light", size: 13)
    }
}

class Theme: ObservableObject{
    @Published var darkColor: Color
    @Published var lightColor: Color
    @Published var backgroundColor: Color
    @Published var contrastBackground: Color
    @Published var secondaryColor: Color
    @Published var shadowColor: Color
    @Published var bodyTextColor: Color
    
    @Published var largeTitle:Font
    @Published var mediumTitle:Font
    @Published var smallTitle:Font
    @Published var body:Font
    @Published var button:Font
    @Published var caption:Font
    
    @Published var largeSpacing:CGFloat
    @Published var mediumSpacing:CGFloat
    @Published var smallSpacing:CGFloat
    
    init(darkColor: Color, backgroundColor: Color, lightColor:Color, contrastBackground: Color, secondaryColor: Color, shadowColor: Color, bodyTextColor: Color, largeTitle: Font, mediumTitle: Font, smallTitle: Font, body: Font, button: Font, caption: Font, largeSpacing: CGFloat, mediumSpacing: CGFloat, smallSpacing: CGFloat) {
        self.darkColor = darkColor
        self.lightColor = lightColor
        self.backgroundColor = backgroundColor
        self.contrastBackground = contrastBackground
        self.secondaryColor = secondaryColor
        self.shadowColor = shadowColor
        self.bodyTextColor = bodyTextColor
        
        self.largeTitle = largeTitle
        self.mediumTitle = mediumTitle
        self.smallTitle = smallTitle
        self.body = body
        self.button = button
        self.caption = caption
        
        self.largeSpacing = largeSpacing
        self.mediumSpacing = mediumSpacing
        self.smallSpacing = smallSpacing
    }
    
}

var themes: [Theme] = [
    Theme(
        darkColor: Color(hex: 0x36374b),
        backgroundColor: Color(hex:0xe8dbcb),
        lightColor:Color(hex: 0xF6F6F6),
        contrastBackground: Color(hex: 0xe2b9b3),
        secondaryColor: Color(hex:0x7bb4ae),
        shadowColor: Color(hex:0xb0413e),
        bodyTextColor: Color(hex:0x3B3B3B),
        
        largeTitle: getFont(name: .largeTitle),
        mediumTitle: getFont(name: .mediumTitle),
        smallTitle: getFont(name: .smallTitle),
        body: getFont(name: .body),
        button: getFont(name: .button),
        caption: getFont(name: .caption),
        
        largeSpacing: 16.0,
        mediumSpacing: 6.0,
        smallSpacing: 4.0)
    ,
    Theme(
        darkColor: Color(hex: 0x36374b),
        backgroundColor: Color(hex:0xe8dbcb),
        lightColor:Color(hex: 0xF6F6F6),
        contrastBackground: Color(hex: 0xe2b9b3),
        secondaryColor: Color(hex:0x7bb4ae),
        shadowColor: Color(hex:0xb0413e),
        bodyTextColor: Color(hex:0x3B3B3B),
        
        largeTitle: getFont(name: .largeTitle),
        mediumTitle: getFont(name: .mediumTitle),
        smallTitle: getFont(name: .smallTitle),
        body: getFont(name: .body),
        button: getFont(name: .button),
        caption: getFont(name: .caption),
        
        largeSpacing: 16.0,
        mediumSpacing: 6.0,
        smallSpacing: 4.0)


]

var currentTheme:Theme = themes[0]

struct Theme_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            VStack{
                Text("This is some large title text").font(currentTheme.largeTitle)
                Text("This is some medium title text").font(currentTheme.mediumTitle)
                Text("This is some small title text").font(currentTheme.smallTitle)
                Text("This is some body text").font(currentTheme.body)
                Text("This is some button text").font(currentTheme.button)
                Text("This is some caption text").font(currentTheme.caption)
            }
        }
    }
}
