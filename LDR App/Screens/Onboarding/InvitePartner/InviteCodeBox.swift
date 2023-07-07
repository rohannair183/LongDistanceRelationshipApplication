//
//  InviteCodeBox.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-22.
//

import SwiftUI

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
struct InviteCodeBox: View {
    
    var code:Int
    var body: some View {
        let codeFormated = code.formattedWithSeparator
        VStack(alignment: .leading) {
            Text("Your Invite Code:").font(currentTheme.caption)
            HStack {
                Text("\(String(codeFormated))").font(currentTheme.largeTitle)
                Spacer()
                ShareLink(item: String(codeFormated)) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            Divider().overlay(.gray)
        }.frame(maxWidth: 300)
    }
}

struct InviteCodeBox_Previews: PreviewProvider {
    static var previews: some View {
        InviteCodeBox(code:590434)
    }
}
