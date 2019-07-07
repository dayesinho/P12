//
//  BreachModel.swift
//  PwLocker
//
//  Created by Tavares on 30/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import Foundation

struct BreachModel: Decodable {
    
    var datetimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        return formatter
    }()
    
    /// iso 8901: yyyy-MM-dd
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter
    }()
    
    public let name: String
    public let title: String
    public let domain: String
    public let logoPath: String
    public let breachDate: Date
    public let addedDate: Date
    public let modifiedDate: Date
    public let pwnCount: UInt
    public let description: String
    public let dataClasses: [String]
    
    enum CodingKeys: String, CodingKey {
 
        case name = "Name"
        case title = "Title"
        case domain = "Domain"
        case breachDate = "BreachDate"
        case logoPath = "LogoPath"
        case addedDate = "AddedDate"
        case modifiedDate = "ModifiedDate"
        case pwnCount = "PwnCount"
        case description = "Description"
        case dataClasses = "DataClasses"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.title = try container.decode(String.self, forKey: .title)
        self.domain = try container.decode(String.self, forKey: .domain)
        self.description = try container.decode(String.self, forKey: .description)
        logoPath = try container.decode(String.self, forKey: .logoPath)
        
        self.dataClasses = try container.decode([String].self, forKey: .dataClasses)
        
        self.pwnCount = try container.decode(UInt.self, forKey: .pwnCount)
        
        do {
            let iso8601: String = try container.decode(String.self, forKey: .addedDate)
            self.addedDate = datetimeFormatter.date(from: iso8601) ?? Date(timeIntervalSince1970: 0)
        }
        
        do {
            let iso8601: String = try container.decode(String.self, forKey: .modifiedDate)
            self.modifiedDate = datetimeFormatter.date(from: iso8601) ?? Date(timeIntervalSince1970: 0)
        }
        
        do {
            let iso8601: String = try container.decode(String.self, forKey: .breachDate)
            self.breachDate = dateFormatter.date(from: iso8601) ?? Date(timeIntervalSince1970: 0)
        }
    }
}
