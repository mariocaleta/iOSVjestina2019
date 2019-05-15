//
//  QuizesTableViewFooterView.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 16/05/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import UIKit
import PureLayout

class QuizesTableViewFooterView: UIView {

    var signOutButton: UIButton!
    
    @objc func signOutButtonTapped(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "accessToken")
        userDefaults.removeObject(forKey: "id")
        
        let accessToken = userDefaults.string(forKey: "accessToken")
        let id = userDefaults.string(forKey: "id")
        
        if (accessToken == nil || id == nil){
            let vc = LogInViewController()
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = vc
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        signOutButton = UIButton()
        signOutButton.setTitle("Sign out", for: UIControl.State.normal)
        addSubview(signOutButton)
        signOutButton.autoAlignAxis(.vertical, toSameAxisOf: self)
        signOutButton.autoPinEdge(.top, to: .bottom, of: self, withOffset: 16.0)
        signOutButton.autoSetDimension(.height, toSize: 30)
        signOutButton.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -16.0)
        signOutButton.addTarget(self, action: #selector(QuizesTableViewFooterView.signOutButtonTapped(_:)), for: UIControl.Event.touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
