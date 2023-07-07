//
//  codeInputField.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-22.
//

import SwiftUI

//Move to some other place
extension String {
    subscript(_ n: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: n)]
    }
}

struct codeInputField: View {
    @Binding var enteredValue:[String]
    @FocusState private var fieldFocus: Int?
    
    
    var body: some View {
        let numberofFields:Int = enteredValue.count
        HStack{
            ForEach(0..<numberofFields, id: \.self) {index in
                TextField("", text: $enteredValue[index])
                    .frame(width:48, height: 48)
                    .keyboardType(.decimalPad)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                    .textContentType(.oneTimeCode)
                    .multilineTextAlignment(.center)
                    .font(currentTheme.smallTitle)
                    .focused($fieldFocus, equals:index)
                    .tag(index)
                    .onChange(of: enteredValue[index]){newValue in
                        if newValue.count >= 2 {
                            enteredValue[index] = String(newValue[1])
                        }
                        
                        fieldFocus = (fieldFocus ??  0) + 1
                    }
            }
        }
        
    }
}
struct codeInputField_Previews: PreviewProvider {
    static var previews: some View {
        @State var stringArray = Array(repeating: "", count: 6)
        codeInputField(enteredValue: $stringArray)
    }
}
