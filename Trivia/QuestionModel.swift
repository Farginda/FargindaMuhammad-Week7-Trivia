//
//  QuestionModel.swift
//  Trivia
//
//  Created by Farginda on 12/11/18.
//  Copyright © 2018 Farginda. All rights reserved.
//

import Foundation
import HTMLString

// question struct
struct Question: Codable {
    var category: String
    var type: String
    var question: String
    var correctAnswer: String
    var incorrectAnswers: [String]
    
    
    enum CodingKeys: String, CodingKey {
        case category
        case type
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}

// questions struct that depends on the question struct
struct Questions: Codable {
    let results: [Question]
}
