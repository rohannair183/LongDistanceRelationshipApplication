//
//  SecureTextInputField.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-18.
//

import SwiftUI

struct SecureTextInputField: View {
    @Binding var text: String
    let placeHolder: String
    let keyboardType: UIKeyboardType
    let sfSymbol: String?
    
    var body: some View {
        
        HStack{
            if let sysImage = sfSymbol{
                Image(systemName: sysImage).foregroundColor(.gray).padding()
            }
            SecureField(placeHolder, text: $text)
                .padding()
                .keyboardType(keyboardType)
        }.cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 2))
        
    }
    
}

struct SecureTextInputField_Previews: PreviewProvider {
    static var previews: some View {
        SecureTextInputField(text: .constant(""), placeHolder: "Password", keyboardType: .default, sfSymbol: "lock")
    }
}
