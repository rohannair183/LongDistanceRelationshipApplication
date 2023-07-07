//
//  CalendarScreen.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-28.
//

import SwiftUI

struct CalendarScreen: View {
    var body: some View {
        ScrollView{
            CalendarView(interval: DateInterval(start: .distantPast, end: .distantFuture))
        }
    }
}

struct CalendarScreen_Previews: PreviewProvider {
    static var previews: some View {
        CalendarScreen()
    }
}
