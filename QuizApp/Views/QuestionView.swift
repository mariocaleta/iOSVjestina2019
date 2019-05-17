//
//  QuestionView.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 09/04/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import UIKit

class QuestionView: UIView {

    var questionText: UILabel?
    var button1: UIButton?
    var button2: UIButton?
    var button3: UIButton?
    var button4: UIButton?
    var correctAnswer: Int?
    
    convenience init(frame: CGRect, question : Questions) {
        self.init(frame: frame)
        
        correctAnswer = question.correct_answer
        
        questionText = UILabel(frame: CGRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: 340, height: 50)))
        questionText?.text = question.question
        questionText?.textAlignment = .center
        questionText?.backgroundColor = .gray
        
        button1 = UIButton(frame: CGRect(x: 10, y: 100, width: 150, height: 50))
        button1?.backgroundColor = .gray
        button1?.tag = 0
        button1?.setTitle(question.answers![0], for: .normal)
        button1?.addTarget(self, action: #selector(QuestionView.buttonAction), for: UIControl.Event.touchUpInside)
        
        button2 = UIButton(frame: CGRect(x: 200, y: 100, width: 150, height: 50))
        button2?.backgroundColor = .gray
        button2?.tag = 1
        button2?.setTitle(question.answers![1], for: .normal)
        button2?.addTarget(self, action: #selector(QuestionView.buttonAction), for: UIControl.Event.touchUpInside)
        
        button3 = UIButton(frame: CGRect(x: 10, y: 200, width: 150, height: 50))
        button3?.backgroundColor = .gray
        button3?.tag = 2
        button3?.setTitle(question.answers![2], for: .normal)
        button3?.addTarget(self, action: #selector(QuestionView.buttonAction), for: UIControl.Event.touchUpInside)
        
        button4 = UIButton(frame: CGRect(x: 200, y: 200, width: 150, height: 50))
        button4?.backgroundColor = .gray
        button4?.tag = 3
        button4?.setTitle(question.answers![3], for: .normal)
        button4?.addTarget(self, action: #selector(QuestionView.buttonAction), for: UIControl.Event.touchUpInside)
        
        
        if let button = button1{
            self.addSubview(button)
        }
        
        if let button = button2{
            self.addSubview(button)
        }
        
        if let button = button3{
            self.addSubview(button)
        }
        
        if let button = button4{
            self.addSubview(button)
        }
        
        if let questionText = questionText {
            self.addSubview(questionText)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        if sender.tag == correctAnswer{
           sender.backgroundColor = .green
           for i in 1..<4 {
                if let Button = self.viewWithTag(i) as? UIButton{
                    Button.isEnabled = false
                }
            }
        }
        else{
            sender.backgroundColor = .red
        }
    }
    
}
