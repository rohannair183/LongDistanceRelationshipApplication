//
//  NormalTextInput.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-18.
//

import SwiftUI

struct TextInputField: View {
    
    @Binding var text: String
    let placeHolder: String
    let keyboardType: UIKeyboardType
    let sfSymbol: String?
    
    var body: some View {
        
       
            HStack{
                if let sysImage = sfSymbol{
                    Image(systemName: sysImage).foregroundColor(.gray).padding()
                }
                TextField(placeHolder, text: $text)
                    .padding()
//                    .frame(maxWidth: .infinity)
                    .keyboardType(keyboardType)
            }.cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 2))
           
    }
}

struct NormalTextInput_Previews: PreviewProvider {
    static var previews: some View {
        TextInputField(text: .constant(""), placeHolder: "Email", keyboardType: .emailAddress, sfSymbol: "envelope")
    }
}
