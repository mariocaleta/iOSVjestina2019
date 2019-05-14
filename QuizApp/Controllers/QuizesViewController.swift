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
    
    let cellReuseIdentifier = "cellReuseIdentifier"
    
    var viewModel: QuizesViewModel!
    
    convenience init(viewModel: QuizesViewModel){
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
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
    }
    
    func bindViewModel() {
        
        // Ovim pozivom metode fetchReviews, viewModela govorimo viewModelu da dohvati podatke sa servera i nakon dohvacanja refreshamo tableView
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
}

extension QuizesViewController: UITableViewDelegate {
    // metoda UITableView delegata koju UITableView zove kada zeli dobiti visinu celije za oderedeni indexPath
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    // metoda UITableView delegata koju UITableView zove kada zeli dobiti view za header jedne sekcije
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = QuizesTableSectionHeader()
        return view
    }
    
    // metoda UITableView delegata koju UITableView zove kada zeli dobiti visinu view-a hedera jedne sekcije
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    // metoda UITableView delegata koju UITableView zove kada se dogodi tap na neku celiju na indexPath-u
  //  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  //      tableView.deselectRow(at: indexPath, animated: true)
  //
  //      if let viewModel = viewModel.viewModel(atIndex: indexPath.row) {
  //          let singleReviewViewController = SingleReviewViewController(viewModel: viewModel)
  //          navigationController?.pushViewController(singleReviewViewController, animated: true)
  //      }
  //  }
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
        if let review = viewModel.quiz(atIndex: indexPath.row) {
            cell.setup(withQuiz: review)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Metode dataSource-a koju UITableView zove da dobije broj redaka koje treba prikazati u tablici
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // pitamo viewModel za broj redaka koje treba prikazati, viewModel ima informaciju o modelu, viewModel je dataSoruce ovog viewControllera
        return viewModel.numberOfQuizes()
    }
}
