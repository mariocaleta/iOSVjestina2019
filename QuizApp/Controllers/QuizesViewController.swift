//
//  QuizesViewController.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 13/05/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import UIKit

class QuizesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var tableFooterView: QuizesTableViewFooterView!
    
    let cellReuseIdentifier = "cellReuseIdentifier"
    
    var viewModel: QuizesViewModel!
    
    convenience init(viewModel: QuizesViewModel){
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        bindViewModel()
        super.viewDidLoad()
        self.title = "Quizes"
        setupTableView()
        self.refresh()
    }

    func setupTableView() {
        tableView.backgroundColor = UIColor.lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(QuizesViewController.refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.register(UINib(nibName: "QuizesTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
        tableFooterView = QuizesTableViewFooterView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
        tableView.tableFooterView = tableFooterView
    }
    
    func bindViewModel() {
        viewModel.fetchQuizes {
            self.refresh()
        }
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc func sendResults(sender: UIButton){
        let resultsViewController = ResultsViewController(quizId: sender.tag)
        navigationController?.pushViewController(resultsViewController, animated: true)
    }
}

extension QuizesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = QuizesTableSectionHeader()
        view.titleLabel.text = viewModel.categorys[section]
        if(viewModel.categorys[section] == "SPORTS"){
            view.backgroundColor = CategoryType.sports.color
        }else if(viewModel.categorys[section] == "SCIENCE"){
            view.backgroundColor = CategoryType.science.color
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let viewModel = viewModel.singleQuizViewModel(atIndex: viewModel.sortedQuizes[indexPath.section][indexPath.row]) {
            let singleQuizViewController = SingleQuizViewController(viewModel: viewModel)
            navigationController?.pushViewController(singleQuizViewController, animated: true)
        }
    }
}

extension QuizesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! QuizesTableViewCell
        cell.resultsButton.tag = Int(viewModel.sortedQuizes[indexPath.section][indexPath.row].id)
        cell.resultsButton.addTarget(self, action: #selector(QuizesViewController.sendResults), for: .touchUpInside)
        if let review = viewModel.cellForRow(quiz: viewModel.sortedQuizes[indexPath.section][indexPath.row]){
            cell.setup(withQuiz: review)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.categorys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sortedQuizes[section].count
    }
}
