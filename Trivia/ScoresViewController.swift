//
//  ScoresViewController.swift
//  Trivia
//
//  Created by Farginda on 12/10/18.
//  Copyright © 2018 Farginda. All rights reserved.
//

import UIKit

class ScoresViewController: UIViewController {
    var questions = [Question]()
    var score = 0
    var highscores = [Player]()
    
    // outlets
    @IBOutlet weak var congratsLabel: UILabel!
    @IBOutlet weak var userScoreLabel: UILabel!
    @IBOutlet weak var enterLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        if score >= 5 {
            userScoreLabel.text = "Congrats! You have answered \(score) out of the 10 questions correctly!"
        } else if score < 5 {
        userScoreLabel.text = "Better luck next time. You have answered \(score) out of the 10 questions correctly."
        }
        super.viewDidLoad()
    }
    
    func viewHighScores() {
        QuestionHelper.shared.fetchHighScores() { (highscores) in
            if let highscores = highscores {
                self.highscores = highscores
            }
        }
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        let url = URL(string: "https://ide50-farginda.cs50.io:8080/list")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "name=\(nameTextField.text!)&score=\(score)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.viewHighScores()
        }
        task.resume()
        
    }
}
