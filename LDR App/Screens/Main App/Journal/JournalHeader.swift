//
//  JournalHeader.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-08-01.
//

import SwiftUI

struct JournalHeader: View {
    @ObservedObject var appState: AppState
    @State var date: Date
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .background(.ultraThinMaterial)
                    .edgesIgnoringSafeArea(.top)
                HStack {
                    Spacer()
                    Text(date.formatted(date: .abbreviated, time: .omitted)).font(currentTheme.smallTitle)
                    Spacer()
                    NavigationLink{
                        AllPromptScreen(appState: appState)
                    }label: {
                        Image(systemName: "doc.plaintext")
                            .font(.system(size:25))
                    }
                    

                    
                }.padding([.leading, .trailing])
            }.frame(maxWidth: .infinity).frame(height: 50)
        }
    }
}

struct JournalHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            JournalHeader(appState: AppState(), date: Date.now)
            Spacer()
        }
    }
}
