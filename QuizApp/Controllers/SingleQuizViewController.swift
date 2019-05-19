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
    var timeOfStart: Date!
    var time: Double!
    @IBAction func startQuizButtonTapped(_ sender: UIButton) {
        self.scrollView.isHidden = false
        self.button.isHidden = true
        timeOfStart = Date()
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
    
    func displayFailMessage(userMessage : String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            let sendAgain = UIAlertAction(title: "Pošalji ponovno", style: .default){
                (action:UIAlertAction!) in
                DispatchQueue.main.async {
                    let postResultService = PostResultService()
                    postResultService.postResult(quizId: self.viewModel.quiz!.id!, time: self.time, numberOfCorrectAnswers: self.numberOfCorrectAnswers){
                        (result) in
                        DispatchQueue.main.async {
                            print(result!)
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            }
            let OkAction = UIAlertAction(title: "Novi kviz", style: .default){
                (action:UIAlertAction!) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
            }
            alertController.addAction(sendAgain)
            alertController.addAction(OkAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func displaySuccessMessage(userMessage : String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Čestitamo!", message: userMessage, preferredStyle: .alert)
            let OkAction = UIAlertAction(title: "Novi kviz", style: .default){
                (action:UIAlertAction!) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
            }
            alertController.addAction(OkAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension SingleQuizViewController : QuestionViewDelegate {
    func moveToNextQusetion(correctAnswer: Bool) {
        if(correctAnswer == true){
            numberOfCorrectAnswers += 1
        }
        
        let pageWidth:CGFloat = self.scrollView.frame.width
        let maxWidth:CGFloat = pageWidth * CGFloat(viewModel.quiz!.questions!.count)
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
            time = Date().timeIntervalSince(timeOfStart)
            print(time!)
            let postResultService = PostResultService()
            postResultService.postResult(quizId: viewModel.quiz!.id!, time: time, numberOfCorrectAnswers: numberOfCorrectAnswers){
                (result) in
                DispatchQueue.main.async {
                    switch result {
                    case ResponseCode.success.code:
                        print("Uspješno poslano")
                        self.displaySuccessMessage(userMessage: "Uspješno poslani rezultati kviza!")
                    case ResponseCode.unauthorized.code:
                        print("Unauthorized")
                        self.displayFailMessage(userMessage: "Nepostojeći token!")
                    case ResponseCode.forbidden.code:
                        print("Forbidden")
                        self.displayFailMessage(userMessage: "Token ne odgovara useru!")
                    case ResponseCode.notFound.code:
                        print("Not found")
                        self.displayFailMessage(userMessage: "quiz_id ne postoji!")
                    case ResponseCode.badRequest.code:
                        print("Bad request")
                        self.displayFailMessage(userMessage: "time nije decimalni broj ili no_of_correct nije integer")
                    default:
                        print("Default")
                    }
                }
            }
        }else{
            self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
        }
    }
}
