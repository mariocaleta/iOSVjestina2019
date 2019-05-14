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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
