//
//  QuizesTableViewCell.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 14/05/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import UIKit

class QuizesTableViewCell: UITableViewCell {

    @IBOutlet weak var quizTitleLabel: UILabel!
    @IBOutlet weak var quizDescriptionLabel: UILabel!
    @IBOutlet weak var quizLevelLabel: UILabel!
    @IBOutlet weak var quizImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        quizTitleLabel.text = ""
        quizDescriptionLabel.text = ""
        quizLevelLabel.text = ""
        quizImageView?.image = nil
    }
    
    
    
}
