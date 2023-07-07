//
//  CalendarView.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-28.
//

import SwiftUI

struct CalendarView:UIViewRepresentable{
    let interval: DateInterval
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        return view
        
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }
    
    
    
}
