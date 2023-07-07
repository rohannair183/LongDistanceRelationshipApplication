//
//  User.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-19.
//

import Foundation
import FirebaseFirestoreSwift

class User: Codable, ObservableObject, Identifiable{
    @Published var id: String
    @Published var firstName: String
    @Published var lastName: String
    @Published var email: String
    @Published var partnerJoined: Bool
    @Published var partnerId: String?
    @Published var joinCode: Int? = nil
    
    enum CodingKeys: String, CodingKey {
            case id
            case firstName = "first name"
            case lastName = "last name"
            case email
            case partnerJoined = "partner joined"
            case partnerId = "partner id"
            case joinCode = "join code"
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            firstName = try container.decode(String.self, forKey: .firstName)
            lastName = try container.decode(String.self, forKey: .lastName)
            email = try container.decode(String.self, forKey: .email)
            partnerJoined = try container.decode(Bool.self, forKey: .partnerJoined)
            partnerId = try container.decodeIfPresent(String.self, forKey: .partnerId)
            joinCode = try container.decodeIfPresent(Int.self, forKey: .joinCode)
        }
    
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(firstName, forKey: .firstName)
            try container.encode(lastName, forKey: .lastName)
            try container.encode(email, forKey: .email)
            try container.encode(partnerJoined, forKey: .partnerJoined)
            try container.encode(partnerId, forKey: .partnerId)
            try container.encode(joinCode, forKey: .joinCode)

        }
    
    init(id: String = UUID().uuidString, firstName: String, lastName: String, email: String, partnerJoined: Bool, partnerId: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.partnerJoined = partnerJoined
        self.partnerId = partnerId
    }
    
   
}
