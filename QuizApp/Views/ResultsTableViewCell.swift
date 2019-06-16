//
//  ResultsTableViewCell.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 14/06/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var IndexLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var UsernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        IndexLabel.text = ""
        ScoreLabel.text = ""
        UsernameLabel.text = ""
    }
    
    func setup(withResult result: Results){
       ScoreLabel.text = "Score : " + result.score!
        UsernameLabel.text = "User : " + result.username!
    }
}
