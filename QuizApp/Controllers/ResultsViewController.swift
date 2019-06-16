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
    var results: [Results] = []
    
    var refreshControl: UIRefreshControl!
    
    let cellReuseIdentifier = "cellReuseIdentifier"

    convenience init(quizId: Int) {
        self.init()
        self.quizId = quizId
    }
    
    override func viewDidLoad() {
        bindViewModel()
        super.viewDidLoad()
        self.title = "Leaderboard"
        setupTableView()
        self.refresh()
    }

    func setupTableView() {
        tableView.backgroundColor = UIColor.lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ResultsViewController.refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.register(UINib(nibName: "ResultsTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func bindViewModel() {
        let resultsService = ResultsService()
        resultsService.fetchResults(quizId: quizId){
            (results) in
            DispatchQueue.main.async {
                self.results = results ?? []
                self.refresh()
            }
        }
        
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}

extension ResultsViewController: UITableViewDelegate {
    // metoda UITableView delegata koju UITableView zove kada zeli dobiti visinu celije za oderedeni indexPath
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
}

extension ResultsViewController: UITableViewDataSource {
    
    // Metoda UITableView dataSource-a koju UITableView zove da dobije UITableViewCell koji ce prikazati za odredeni indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ResultsTableViewCell
        cell.IndexLabel.text = String(indexPath.row + 1) + "."
        cell.setup(withResult: self.results[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Metode dataSource-a koju UITableView zove da dobije broj redaka koje treba prikazati u tablici
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    

}
