//
//  InitialViewController.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 06/04/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    
    @IBOutlet weak var dohvatiButton: UIButton!
    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet weak var hiddenLabel: UILabel!
    @IBOutlet weak var quizCategoryLabel: UILabel!
    @IBOutlet weak var quizImageView: UIImageView!
    @IBOutlet weak var questionCustomView: UIView!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        fetchQuiz()
        
    }
    
    
    func fetchQuiz(){
        let quizService = QuizService()
        quizService.fetchQuiz(){ (responseModel) in
            DispatchQueue.main.async {
                if let responseModel = responseModel {
        
                    //let nbaCount = responseModel.quizzes!.filter{$0[Questions["question"]].contains("NBA")}
                    var nbaCount = 0
                    
                    for i in 0..<responseModel.quizzes!.count {
                        for j in 0..<responseModel.quizzes![i].questions!.count{
                            if((responseModel.quizzes![i].questions![j].question?.contains("NBA"))!){
                                nbaCount += 1
                            }
                        }
                    }
                    
                    self.funFactLabel.text = "Fun fact: There is \(nbaCount) NBA questions!"
                    self.dohvatiButton.isHidden = true
                    
                    let quizImage = responseModel.quizzes![0].image
                    let quizImageService = QuizImageService()
                    var labelColor = UIColor()
                    if (responseModel.quizzes![0].category == "SPORTS"){
                         labelColor = CategoryType.sports.color
                    }
                    else if (responseModel.quizzes![0].category == "SCIENCE"){
                        labelColor = CategoryType.science.color
                    }
                    
                    if quizImage != nil {
                    quizImageService.fetchQuizImage(quizImage: quizImage!) { (image) in
                        DispatchQueue.main.async {
                            self.quizImageView.image = image
                            print("image set")
                            self.quizCategoryLabel.backgroundColor = labelColor
                            self.quizCategoryLabel.text = responseModel.quizzes![0].title
                            }
                        }
                    }
                    else {
                        self.quizImageView.backgroundColor = labelColor
                        self.quizCategoryLabel.backgroundColor = labelColor
                        self.quizCategoryLabel.text = responseModel.quizzes![0].title
                    }
                    
                    self.addQuestionCustomView(quiz: responseModel)
                    
                }
                else{
                    self.hiddenLabel.isHidden = false
                }
            }
            
        }
    }
    
    func addQuestionCustomView(quiz: Quiz) {
        
        let questionView = QuestionView(frame: CGRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: 500, height: 500)), quiz: quiz)
        questionCustomView.addSubview(questionView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view. 
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
