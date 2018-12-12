//
//  Highscore.swift
//  Trivia
//
//  Created by Farginda on 12/11/18.
//  Copyright © 2018 Farginda. All rights reserved.
//

import Foundation

struct Player: Codable {
    var name: String
    var score: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case score
    }
}
