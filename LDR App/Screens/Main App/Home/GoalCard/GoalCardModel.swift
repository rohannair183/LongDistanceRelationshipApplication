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
        case perDay = "Day"
        case perWeek = "Week"
        case perMonth = "Month"
        case perYear = "Year"
        
        var getUnit: Calendar.Component{
            switch self {
            case .perDay:
                return .day
            case .perWeek:
                return .day
            case .perMonth:
                return .month
            case .perYear:
                return .year
            }
        }

        var getValue: Int{
            switch self {
            case .perDay:
                return 1
            case .perWeek:
                return 7
            case .perMonth:
                return 1
            case .perYear:
                return 1
            }
        }
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
    var setCurrentTimeInterval: DateInterval{
        var curInterval = getInterval(startInterval: self.dateStart, unit: unit)
        if (Date.now < self.dateStart) || curInterval.contains(Date.now){
            return curInterval
        }else{
            while !curInterval.contains(Date.now){
                curInterval = getInterval(startInterval: curInterval.end, unit: unit)
            }
            return curInterval
        }
    }
    var currentTimeInterval: DateInterval?
    
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
        case currentTimeInterval = "current time interval"
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
        currentTimeInterval = try container.decode(DateInterval?.self, forKey: .currentTimeInterval)
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
        try container.encode(currentTimeInterval, forKey: .currentTimeInterval)
    }
    
    init (id: String = UUID().uuidString, title: String, competitionMode: Bool, frequency: Frequency, unit: Unit, userCompleted:Float, partnerCompleted:Float, dateStart:Date = Date.now, dateEnd:Date = .distantFuture, currentTimeInterval:DateInterval? = nil){
        self.id = id
        self.title = title
        self.competitionMode = competitionMode
        self.frequency = frequency
        self.unit = unit
        self.userCompleted = userCompleted
        self.partnerCompleted = partnerCompleted
        self.dateStart = Calendar.current.startOfDay(for:dateStart)
        self.dateEnd = Calendar.current.startOfDay(for:dateEnd)
        self.currentTimeInterval = currentTimeInterval
    }
    
    func getInterval(startInterval:Date, unit:Unit) -> DateInterval{
        let endInterval = Calendar.current.date(byAdding: unit.getUnit, value: unit.getValue, to: startInterval)!
        return DateInterval(start: startInterval, end: endInterval)
    }
    
    static var sampleCards = [GoalCardModel(title: "Drink 2L of water per day", competitionMode: true, frequency: Frequency.fourTimes, unit: Unit.perMonth, userCompleted: 2, partnerCompleted: 3), GoalCardModel(title: "Read 5 books", competitionMode: true, frequency: Frequency.fiveTimes, unit: Unit.perMonth, userCompleted: 3, partnerCompleted: 2), GoalCardModel(title: "Facetime 4 times a week", competitionMode: false, frequency: Frequency.fourTimes, unit: Unit.perWeek, userCompleted: 3, partnerCompleted: 7, dateEnd: Date.now.advanced(by: 86400))]
}
