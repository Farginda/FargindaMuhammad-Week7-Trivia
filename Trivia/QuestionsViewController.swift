//
//  QuestionsViewController.swift
//  Trivia
//
//  Created by Farginda on 12/10/18.
//  Copyright © 2018 Farginda. All rights reserved.
//

import UIKit
import HTMLString

class QuestionsViewController: UIViewController {
    
    let questionHelper = QuestionHelper()
    var questions = [Question]()
    var questionIndex = 0
    var score = 0

    // outlets
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        switch sender {
            
        // keep up score for right answers
        case falseButton:
            let question = questions[questionIndex]
            if question.correctAnswer.removingHTMLEntities == "False" {
                score += 1
                UIView.animate(withDuration: 1.0) {
                    self.view.backgroundColor = .green
                }
            } else {
                UIView.animate(withDuration: 1.0) {
                    self.view.backgroundColor = .red
                }
            }
        case trueButton:
            let question = questions[questionIndex]
            if question.correctAnswer.removingHTMLEntities == "True" {
                score += 1
                UIView.animate(withDuration: 1.0) {
                    self.view.backgroundColor = .green
                }
            } else {
                UIView.animate(withDuration: 1.0) {
                    self.view.backgroundColor = .red
                }
            }
        default:
            break
        }
        nextQuestion()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get data questions from api
        questionHelper.fetchQuestions() { (questions) in
            if let questions = questions {
                self.updateUI(with: questions)
            }
        }
    }
    
    // function to navigate to next question
    func nextQuestion() {
        questionIndex += 1
        UIView.animate(withDuration: 1.0) {
            self.view.backgroundColor = .white
        }
        if questionIndex < questions.count {
            self.updateUI(with: questions)
        } else {
            performSegue(withIdentifier: "highscoreSegue", sender: nil)
        }
    }
    
    // update labels and answers
    func updateUI(with questions: [Question]) {
        self.questions = questions
        DispatchQueue.main.async {
            let currentQuestion = questions[self.questionIndex]
            let totalProgress = Float(self.questionIndex) / Float(questions.count)
            self.questionLabel.text = currentQuestion.question.removingHTMLEntities
            self.progress.setProgress(totalProgress, animated: true)
            self.questionNumberLabel.text = "Question #\(self.questionIndex+1)"
        }
    }
    
    // prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "highscoreSegue" {
            let scoresViewController = segue.destination as! ScoresViewController
            scoresViewController.questions = questions
            scoresViewController.score = score
        }
    }
}
