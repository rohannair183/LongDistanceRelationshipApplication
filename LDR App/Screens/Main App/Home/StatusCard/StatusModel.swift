//
//  StatusModel.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-07-26.
//

import Foundation

struct StatusModel: Codable{
    var emoji: String 
    var note: String
    
    static var exampleStatus = StatusModel(emoji: "☺️", note: "Hope you have a great day :)")
}
