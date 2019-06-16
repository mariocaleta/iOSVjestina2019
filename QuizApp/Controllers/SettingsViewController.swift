//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 15/06/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var UsernameLabel: UILabel!
    @IBAction func SignOutButtonTapped(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "accessToken")
        userDefaults.removeObject(forKey: "id")
        userDefaults.removeObject(forKey: "username")
        
        let accessToken = userDefaults.string(forKey: "accessToken")
        let id = userDefaults.string(forKey: "id")
        
        if (accessToken == nil || id == nil){
            let vc = LogInViewController()
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = vc
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        let username = userDefaults.string(forKey: "username")
        UsernameLabel.text = "Username: " + username!
    }
}
