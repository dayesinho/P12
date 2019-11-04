//
//  EmailBreach.swift
//  PwLocker
//
//  Created by Tavares on 30/06/2019.
//  Copyright © 2019 Tavares. All rights reserved.
//

import Foundation

struct EmailBreachModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case breachDate = "BreachDate"
        case domain = "Domain"
        case datail = "Description"
        case logoPath = "LogoPath"
    }
    
    var domain: String
    var name: String
    var beachDate: String
    var detail: String
    var logoPath: String
    
     init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        domain = try values.decode(String.self, forKey: .domain)
        name = try values.decode(String.self, forKey: .name)
        beachDate = try values.decode(String.self, forKey: .breachDate)
        detail = try values.decode(String.self, forKey: .datail)
        logoPath = try values.decode(String.self, forKey: .logoPath)
    }
}
