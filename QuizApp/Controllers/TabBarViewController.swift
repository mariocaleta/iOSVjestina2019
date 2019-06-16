//
//  TabBarViewController.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 15/06/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc = QuizesViewController(viewModel: QuizesViewModel())
        let nvc = UINavigationController(rootViewController: vc)
        nvc.tabBarItem = UITabBarItem(title: "Quizes", image: UIImage(named: "quiz"), tag: 0)
        
        let vc2 = SearchQuizesViewController(viewModel: QuizesViewModel())
        let nvc2 = UINavigationController(rootViewController: vc2)
        nvc2.tabBarItem = UITabBarItem(tabBarSystemItem: .search,  tag: 0)
        
        let vc3 = SettingsViewController()
        vc3.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), tag: 0)
        
        self.viewControllers = [nvc, nvc2, vc3]
    }
}
