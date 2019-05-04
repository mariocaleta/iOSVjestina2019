//
//  AppDelegate.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 06/04/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let logInViewController = LogInViewController()
        let initialViewController = InitialViewController()
        let userDefaults = UserDefaults.standard
        let accessToken = userDefaults.string(forKey: "accessToken")
        
        if (accessToken == nil){
            window?.rootViewController = logInViewController
        }else{
            window?.rootViewController = initialViewController
        }
       
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
}

