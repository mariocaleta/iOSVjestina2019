//
//  QuestionView.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 09/04/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import UIKit

protocol QuestionViewDelegate: class {
    func moveToNextQusetion(correctAnswer: Bool)
}

class QuestionView: UIView {

    var questionText: UILabel?
    var button1: UIButton?
    var button2: UIButton?
    var button3: UIButton?
    var button4: UIButton?
    var timerLabel: UILabel?
    var seconds = 5
    var timer = Timer()
    var correctAnswer: Int?
    weak var delegate: QuestionViewDelegate?
    
    convenience init(frame: CGRect, question : Questions) {
        self.init(frame: frame)
        
        correctAnswer = question.correct_answer! + 1
        
        questionText = UILabel(frame: CGRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: 340, height: 50)))
        questionText?.text = question.question
        questionText?.textAlignment = .center
        questionText?.backgroundColor = .gray
        
        button1 = UIButton(frame: CGRect(x: 10, y: 100, width: 150, height: 50))
        button1?.backgroundColor = .gray
        button1?.tag = 1
        button1?.setTitle(question.answers![0], for: .normal)
        button1?.addTarget(self, action: #selector(QuestionView.buttonAction), for: UIControl.Event.touchUpInside)
        
        button2 = UIButton(frame: CGRect(x: 200, y: 100, width: 150, height: 50))
        button2?.backgroundColor = .gray
        button2?.tag = 2
        button2?.setTitle(question.answers![1], for: .normal)
        button2?.addTarget(self, action: #selector(QuestionView.buttonAction), for: UIControl.Event.touchUpInside)
        
        button3 = UIButton(frame: CGRect(x: 10, y: 200, width: 150, height: 50))
        button3?.backgroundColor = .gray
        button3?.tag = 3
        button3?.setTitle(question.answers![2], for: .normal)
        button3?.addTarget(self, action: #selector(QuestionView.buttonAction), for: UIControl.Event.touchUpInside)
        
        button4 = UIButton(frame: CGRect(x: 200, y: 200, width: 150, height: 50))
        button4?.backgroundColor = .gray
        button4?.tag = 4
        button4?.setTitle(question.answers![3], for: .normal)
        button4?.addTarget(self, action: #selector(QuestionView.buttonAction), for: UIControl.Event.touchUpInside)
        
        timerLabel = UILabel(frame: CGRect(origin: CGPoint(x: 100, y: 300), size: CGSize(width: 100, height: 50)))
        timerLabel?.text = String(seconds)
        timerLabel?.textAlignment = .center
        timerLabel?.backgroundColor = .gray
        
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
        
        if let timerLabel = timerLabel{
            self.addSubview(timerLabel)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func updateTimer(timer: Timer){
        seconds -= 1
        timerLabel?.text = String(seconds)
        let info = timer.userInfo as! Int
        if(seconds == 0){
            timer.invalidate()
            seconds = 5
            if(info == 1){
                delegate?.moveToNextQusetion(correctAnswer: true)
            }else if(info == 0){
                delegate?.moveToNextQusetion(correctAnswer: false)
            }
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        if sender.tag == correctAnswer{
           sender.backgroundColor = .green
           for i in 1..<5 {
                if let Button = self.viewWithTag(i) as? UIButton{
                    Button.isEnabled = false
                }
            }
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: 1, repeats: true)
        }
        else{
            sender.backgroundColor = .red
            if let Button = self.viewWithTag(correctAnswer!) as? UIButton{
                Button.backgroundColor = .green
            }
            for i in 1..<5 {
                if let Button = self.viewWithTag(i) as? UIButton{
                    Button.isEnabled = false
                }
            }
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: 0, repeats: true)
        }
    }
    
}
