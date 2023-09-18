//
//  Loading.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-08-09.
//

import SwiftUI

struct Loading: View {
    var body: some View {
        VStack{
            ProgressView()
        }.frame(width: .infinity, height: .infinity).background(.gray.opacity(0.4))
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading()
    }
}
