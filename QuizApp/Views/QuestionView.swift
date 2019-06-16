//
//  QuestionView.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 09/04/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import UIKit
import PureLayout

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
    
    convenience init(frame: CGRect, question : Question) {
        self.init(frame: frame)
        
        correctAnswer = Int(question.correctAnswer + 1)
        
        questionText = UILabel()
        questionText?.text = question.question
        questionText?.textAlignment = .center
        questionText?.numberOfLines = 0
        questionText?.font = UIFont.systemFont(ofSize: 20)
        questionText?.backgroundColor = .gray
        if let questionText = questionText {
            self.addSubview(questionText)
        }
        questionText?.autoPinEdge(.top, to: .top, of: self, withOffset: 16)
        questionText?.autoSetDimension(.height, toSize: 100)
        questionText?.autoSetDimension(.width, toSize: 350)
        questionText?.autoAlignAxis(.vertical, toSameAxisOf: self)
        
        button1 = UIButton()
        button1?.backgroundColor = .gray
        button1?.tag = 1
        button1?.setTitle(question.answers[0], for: .normal)
        button1?.addTarget(self, action: #selector(QuestionView.buttonAction), for: UIControl.Event.touchUpInside)
        if let button = button1{
            self.addSubview(button)
        }
        
        button2 = UIButton()
        button2?.backgroundColor = .gray
        button2?.tag = 2
        button2?.setTitle(question.answers[1], for: .normal)
        button2?.addTarget(self, action: #selector(QuestionView.buttonAction), for: UIControl.Event.touchUpInside)
        if let button = button2{
            self.addSubview(button)
        }
        
        button3 = UIButton()
        button3?.backgroundColor = .gray
        button3?.tag = 3
        button3?.setTitle(question.answers[2], for: .normal)
        button3?.addTarget(self, action: #selector(QuestionView.buttonAction), for: UIControl.Event.touchUpInside)
        if let button = button3{
            self.addSubview(button)
        }
        
        button4 = UIButton()
        button4?.backgroundColor = .gray
        button4?.tag = 4
        button4?.setTitle(question.answers[3], for: .normal)
        button4?.addTarget(self, action: #selector(QuestionView.buttonAction), for: UIControl.Event.touchUpInside)
        if let button = button4{
            self.addSubview(button)
        }
        
        timerLabel = UILabel()
        timerLabel?.text = String(seconds)
        timerLabel?.textAlignment = .center
        timerLabel?.backgroundColor = .gray
        if let timerLabel = timerLabel{
            self.addSubview(timerLabel)
        }
        
        button1?.autoPinEdge(.top, to: .bottom, of: questionText!, withOffset: 32)
        button1?.autoPinEdge(.leading, to: .leading, of: self, withOffset: 32)
        button1?.autoSetDimension(.height, toSize: 50)
        button1?.autoSetDimension(.width, toSize: 150)
        
        
        button2?.autoPinEdge(.top, to: .bottom, of: questionText!, withOffset: 32)
        button2?.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -32)
        button2?.autoSetDimension(.height, toSize: 50)
        button2?.autoSetDimension(.width, toSize: 150)
        
        button3?.autoPinEdge(.leading, to: .leading, of: self, withOffset: 32)
        button3?.autoPinEdge(.bottom, to: .top, of: timerLabel!, withOffset: -32)
        button3?.autoSetDimension(.height, toSize: 50)
        button3?.autoSetDimension(.width, toSize: 150)
        
        button4?.autoPinEdge(.bottom, to: .top, of: timerLabel!, withOffset: -32)
        button4?.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -32)
        button4?.autoSetDimension(.height, toSize: 50)
        button4?.autoSetDimension(.width, toSize: 150)
        
        timerLabel?.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -64)
        timerLabel?.autoSetDimension(.height, toSize: 50)
        timerLabel?.autoSetDimension(.width, toSize: 100)
        timerLabel?.autoAlignAxis(.vertical, toSameAxisOf: self)
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
