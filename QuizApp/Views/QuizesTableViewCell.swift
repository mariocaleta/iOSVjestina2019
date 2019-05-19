//
//  QuizesTableViewCell.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 14/05/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import UIKit
import Kingfisher

class QuizesTableViewCell: UITableViewCell {

    @IBOutlet weak var quizTitleLabel: UILabel!
    @IBOutlet weak var quizDescriptionLabel: UILabel!
    @IBOutlet weak var quizLevelLabel: UILabel!
    @IBOutlet weak var quizImageView: UIImageView!
    @IBOutlet weak var resultsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        quizTitleLabel.text = ""
        quizDescriptionLabel.text = ""
        quizLevelLabel.text = ""
        quizImageView?.image = nil
    }
    
    func setup(withQuiz quiz: QuizesCellModel){
        quizTitleLabel.text = quiz.title
        quizDescriptionLabel.text = quiz.description
        if (quiz.level == 1){
            quizLevelLabel.text = "❉"
        }else if(quiz.level == 2){
            quizLevelLabel.text = "❉❉"
        }else if(quiz.level == 3){
            quizLevelLabel.text = "❉❉❉"
        }
        if let url = quiz.imageURL {
            quizImageView.kf.setImage(with: url)
        }
    }
}
