//
//  HighscoreTableViewController.swift
//  Trivia
//
//  Created by Farginda on 12/12/18.
//  Copyright © 2018 Farginda. All rights reserved.
//

import UIKit

class HighscoreTableViewController: UITableViewController {

    var questions = [Question]()
    var highscores = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewWillAppear(true)
        viewHighScores()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }

    func viewHighScores() {
        QuestionHelper.shared.fetchHighScores() { (highscores) in
            if let highscores = highscores {
                self.highscores = highscores
                
                // reload data after fetching highscores
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highscores.count
    }
    
    // set cell text
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let player = highscores[indexPath.row]
        cell.textLabel?.text = player.name
        cell.detailTextLabel?.text = player.score
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}
