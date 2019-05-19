//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 19/05/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var quizId: Int!

    convenience init(quizId: Int) {
        self.init()
        self.quizId = quizId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let resultsService = ResultsService()
        resultsService.fetchResults(quizId: quizId){
            (results) in
            DispatchQueue.main.async {
                print(results)
            }
        }
    }

    

}
