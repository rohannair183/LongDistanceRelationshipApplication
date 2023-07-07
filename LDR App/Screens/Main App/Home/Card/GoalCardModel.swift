//
//  GoalCardModel.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-27.
//

import Foundation
import FirebaseFirestoreSwift

struct GoalCardModel:Identifiable, Codable{
    enum Frequency: Float, Codable, CaseIterable{
        case oneTime = 1
        case twoTimes = 2
        case threeTimes = 3
        case fourTimes = 4
        case fiveTimes = 5
    }
    
    enum Unit: String, Codable, CaseIterable{
        case perDay = "Per Day"
        case perWeek = "Per Week"
        case perMonth = "Per Month"
        case perYear = "Per Year"
    }
    
    var id: String
    var title:String
    var competitionMode:Bool
    var frequency:Frequency
    var unit:Unit
    var userCompleted:Float
    var partnerCompleted:Float
    var dateStart: Date
    var dateEnd: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case competitionMode = "competition mode"
        case frequency
        case unit
        case userCompleted = "user completed"
        case partnerCompleted = "partner completed"
        case dateStart = "date start"
        case dateEnd = "date end"
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        competitionMode = try container.decode(Bool.self, forKey: .competitionMode)
        frequency = try container.decode(Frequency.self, forKey: .frequency)
        unit = try container.decode(Unit.self, forKey: .unit)
        userCompleted = try container.decode(Float.self, forKey: .userCompleted)
        partnerCompleted = try container.decode(Float.self, forKey: .partnerCompleted)
        dateStart = try container.decode(Date.self, forKey: .dateStart)
        dateEnd = try container.decode(Date.self, forKey: .dateEnd)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(competitionMode, forKey: .competitionMode)
        try container.encode(frequency, forKey: .frequency)
        try container.encode(unit, forKey: .unit)
        try container.encode(userCompleted, forKey: .userCompleted)
        try container.encode(partnerCompleted, forKey: .partnerCompleted)
        try container.encode(dateStart, forKey: .dateStart)
        try container.encode(dateEnd, forKey: .dateEnd)

        
        
    }
    
    init (id: String = UUID().uuidString, title: String, competitionMode: Bool, frequency: Frequency, unit: Unit, userCompleted:Float, partnerCompleted:Float, dateStart:Date = Date.now, dateEnd:Date = .distantFuture){
        self.id = id
        self.title = title
        self.competitionMode = competitionMode
        self.frequency = frequency
        self.unit = unit
        self.userCompleted = userCompleted
        self.partnerCompleted = partnerCompleted
        self.dateStart = dateStart
        self.dateEnd = dateEnd
    }
    
    static var sampleCards = [GoalCardModel(title: "Drink 2L of water per day", competitionMode: true, frequency: Frequency.fourTimes, unit: Unit.perMonth, userCompleted: 2, partnerCompleted: 3), GoalCardModel(title: "Read 5 books", competitionMode: true, frequency: Frequency.fiveTimes, unit: Unit.perMonth, userCompleted: 3, partnerCompleted: 2), GoalCardModel(title: "Facetime 4 times a week", competitionMode: false, frequency: Frequency.fourTimes, unit: Unit.perWeek, userCompleted: 3, partnerCompleted: 7, dateEnd: Date.now.advanced(by: 86400))]
}
