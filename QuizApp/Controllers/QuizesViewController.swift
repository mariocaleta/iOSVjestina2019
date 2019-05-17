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
    var data: [[Quizzes]] = []
    var helpArray: [Quizzes] = []
    var categorys: [String] = []
    var quizData: Quiz!
    
    convenience init(viewModel: QuizesViewModel){
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        bindViewModel()
        super.viewDidLoad()
        setupTableView()
        self.refresh()
    }
    
    func setArray(quiz: Quiz){
        for i in 0..<quiz.quizzes!.count{
            print(quiz.quizzes![i].category!)
            categorys.append(quizData.quizzes![i].category!)
        }
        let uniqueCategorys = Array(Set(categorys))
        categorys = uniqueCategorys
        
        for i in 0..<categorys.count{
            for j in 0..<quiz.quizzes!.count{
                if (categorys[i] == quiz.quizzes![j].category){
                    helpArray.append(quiz.quizzes![j])
                }
            }
            data.append(helpArray)
            helpArray.removeAll()
        }
     //   self.refresh()
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
            self.quizData = self.viewModel.quizData()
            self.setArray(quiz: self.quizData!)
            self.refresh()
        }
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}

extension QuizesViewController: UITableViewDelegate {
    // metoda UITableView delegata koju UITableView zove kada zeli dobiti visinu celije za oderedeni indexPath
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    // metoda UITableView delegata koju UITableView zove kada zeli dobiti view za header jedne sekcije
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = QuizesTableSectionHeader()
        view.titleLabel.text = categorys[section]
        if(categorys[section] == "SPORTS"){
            view.backgroundColor = CategoryType.sports.color
        }else if(categorys[section] == "SCIENCE"){
            view.backgroundColor = CategoryType.science.color
        }
        return view
    }
    
    // metoda UITableView delegata koju UITableView zove kada zeli dobiti visinu view-a hedera jedne sekcije
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    // metoda UITableView delegata koju UITableView zove kada se dogodi tap na neku celiju na indexPath-u
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
  
        if let viewModel = viewModel.viewModel(atIndex: indexPath.row) {
            let singleQuizViewController = SingleQuizViewController(viewModel: viewModel)
            navigationController?.pushViewController(singleQuizViewController, animated: true)
        }
    }
}

extension QuizesViewController: UITableViewDataSource {
    
    // Metoda UITableView dataSource-a koju UITableView zove da dobije UITableViewCell koji ce prikazati za odredeni indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // celije 'stvaramo' metodom dequeueReusableCell koja zapravo dohvaca prvu slobodnu celiju iz skupa celija koje UITableView ima stvoreno kod sebe
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! QuizesTableViewCell
        
        // Ovdje pitamo viewModel da nam da 'model' objekt koji ce celija iskoristiti da se napuni podacima
        // Ovdje viewModel vraca objekt tipa ReviewCellModel koji sluzi tome da sadrzi podatke Review-a koji su dovolji ReviewsTableViewCell-u da se njima napuni
        // Ovdje mozemo, ako zelimo bit manje striktni dohvatiti i Review i njega poslati celiji da se napuni podacima
        // Takoder, recimo ako je celija kompliciranija, mozemo dohvatiti novi viewModel koji ce celija korisiti da se napuni podacima i za bilo sto drugo sto joj treba
        if let review = viewModel.cellForRow(quiz: data[indexPath.section][indexPath.row]){
            cell.setup(withQuiz: review)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categorys.count
        //return 1
    }
    
    // Metode dataSource-a koju UITableView zove da dobije broj redaka koje treba prikazati u tablici
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // pitamo viewModel za broj redaka koje treba prikazati, viewModel ima informaciju o modelu, viewModel je dataSoruce ovog viewControllera
        return data[section].count
        //return viewModel.numberOfQuizes()
    }
}
