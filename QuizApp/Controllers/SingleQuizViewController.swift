//
//  SingleQuizViewController.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 17/05/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import UIKit
import Kingfisher

class SingleQuizViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var viewModel: SingleQuizViewModel!
    
    convenience init(viewModel: SingleQuizViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        titleLabel.text = viewModel.title
        imageView.kf.setImage(with: viewModel.imageUrl)
        for i in 0..<viewModel.quiz!.questions!.count{
            
        }
    }
}
