//
//  ButtonStyles.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-16.
//
import SwiftUI

struct PrimaryButton: ButtonStyle {
    @State var currentTheme:Theme = themes[0]
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(currentTheme.darkColor)
            .clipShape(RoundedRectangle(cornerRadius: 15.0))
            .font(currentTheme.button)
            .foregroundColor(currentTheme.lightColor)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.spring(response: 0.9, dampingFraction: 0.6), value: 10)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
struct PrimaryButtonTest: View{
    var body: some View {
        Button("test"){
            
        }.buttonStyle(PrimaryButton())
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButtonTest()
    }
}
