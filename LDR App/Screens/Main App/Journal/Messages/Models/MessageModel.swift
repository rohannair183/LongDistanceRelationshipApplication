//
//  MessageModel.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-08-14.
//

import SwiftUI

struct MessageModel: Codable, Identifiable{
    var id = UUID()
    var date: Date
    var promptNumber: Int? = nil
    var prompt: String? = nil
    var sentByUser: Bool
    var text: String
    
    static var messages: [MessageModel] = [MessageModel(date: Date.now, promptNumber: 0, prompt: PROMPTS[0], sentByUser: true, text: "Hello, how's it going?"), MessageModel(date: Date.now, promptNumber: 0, prompt: PROMPTS[0], sentByUser: false, text: "Meh, it's okay ig")]
}
