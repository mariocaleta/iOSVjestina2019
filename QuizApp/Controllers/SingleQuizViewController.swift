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
    @IBAction func startQuizButtonTapped(_ sender: UIButton) {
        self.scrollView.isHidden = false
        self.button.isHidden = true
    }
    
    var viewModel: SingleQuizViewModel!
    var numberOfCorrectAnswers: Int! = 0
    
    convenience init(viewModel: SingleQuizViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:414)
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width * 10, height:self.scrollView.frame.height)
        self.scrollView.isHidden = true
        bindViewModel()
    }
    
    func bindViewModel() {
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        titleLabel.text = viewModel.title
        imageView.kf.setImage(with: viewModel.imageUrl)
        for i in 0..<viewModel.quiz!.questions!.count{
            let questionView = QuestionView(frame: CGRect(origin: CGPoint(x: scrollViewWidth * CGFloat(i), y: 0), size: CGSize(width: scrollViewWidth, height: scrollViewHeight)), question: viewModel.quiz!.questions![i])
            questionView.delegate = self
            scrollView.addSubview(questionView)
        }
    }
}

extension SingleQuizViewController : QuestionViewDelegate {
    func moveToNextQusetion(correctAnswer: Bool) {
        if(correctAnswer == true){
            numberOfCorrectAnswers += 1
        }
        
        let pageWidth:CGFloat = self.scrollView.frame.width
        let maxWidth:CGFloat = pageWidth * 10
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
        }
       // self.scrollView.contentOffset = CGPoint(x: 414, y: 0)
        self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
    }
}
