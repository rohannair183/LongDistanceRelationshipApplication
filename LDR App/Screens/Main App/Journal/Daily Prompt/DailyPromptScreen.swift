//
//  DailyPromptScreen.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-08-02.
//

import SwiftUI

struct DailyPromptScreen: View {
    var body: some View {
        Text(Date.now.formatted(.dateTime.day().month()))
    }
}

struct DailyPromptScreen_Previews: PreviewProvider {
    static var previews: some View {
        DailyPromptScreen()
    }
}
