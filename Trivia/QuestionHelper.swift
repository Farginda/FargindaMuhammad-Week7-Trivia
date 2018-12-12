//
//  QuestionHelper.swift
//  Trivia
//
//  Created by Farginda on 12/10/18.
//  Copyright © 2018 Farginda. All rights reserved.
//

import Foundation
import UIKit

class QuestionHelper {
    static let shared = QuestionHelper()
    var highscores = [Player]()
    
    let baseurl = URL(string: "https://opentdb.com/api.php?amount=10&category=11&type=boolean")!

    // GET request for questions API
    func fetchQuestions(completion: @escaping ([Question]?) -> Void) {
        let task = URLSession.shared.dataTask(with: baseurl)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            do {
            if let data = data {
                let questions = try jsonDecoder.decode(Questions.self, from: data)
                completion(questions.results)
            } else {
                completion(nil)
            }
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    // get highscores
    func fetchHighScores(completion: @escaping ([Player]?) -> Void) {
        let url = URL(string: "https://ide50-farginda.cs50.io:8080/list")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let highscores = try JSONDecoder().decode([Player].self, from: data)
                    completion(highscores)
                } else {
                    completion(nil)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
