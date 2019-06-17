//
//  LogInViewController.swift
//  QuizApp
//
//  Created by Mario Ćaleta on 11/04/2019.
//  Copyright © 2019 FER. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var LogInButton: UIButton!
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        
        if (userNameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!
        {
            displayMessage(userMessage: "Ispunite sva polja.")
        }
        
        let myActivityIndicator = UIActivityIndicatorView(style: .gray)
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
        view.addSubview(myActivityIndicator)
        
        let logInService = LogInService()
        logInService.fetchAccessToken(username: userNameTextField.text!, password: passwordTextField.text!){
            (accessToken) in
            DispatchQueue.main.async {
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                if accessToken == "No internet" {
                    self.displayMessage(userMessage: "There is no internet connection! Connect to internet and try again!")
                }
                if accessToken == nil{
                    self.displayMessage(userMessage: "Korisničko ime ili šifra su netočni. Molimo vas pokušajte ponovno.")
                }else{
                    self.animateEverythingOut { _ in
                        let appDelegate = UIApplication.shared.delegate
                        appDelegate?.window??.rootViewController = TabBarViewController()
                    }
                }
            }
        }
    }
    
    func displayMessage(userMessage : String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            let OkAction = UIAlertAction(title: "OK", style: .default){
                (action:UIAlertAction!) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            alertController.addAction(OkAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func removeActivityIndicator(activityIndicator : UIActivityIndicatorView){
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if (userNameTextField.isFirstResponder || passwordTextField.isFirstResponder) {
                self.view.frame.origin.y = -keyboardSize.height + 150
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        prepareForAnimating()
        animateEverythingIn()
    }
    
    private func prepareForAnimating() {
        userNameTextField.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        userNameTextField.alpha = 0.0
        
        passwordTextField.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        passwordTextField.alpha = 0.0
        
        LogInButton.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        LogInButton.alpha = 0.0
        
        titleLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
        titleLabel.alpha = 0.0
    }
    
    
    private func animateEverythingIn() {
        UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.userNameTextField.transform = CGAffineTransform.identity
            self.userNameTextField.alpha = 1.0
        })
        
        UIView.animate(withDuration: 0.7, delay: 0.1, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.passwordTextField.transform = CGAffineTransform.identity
            self.passwordTextField.alpha = 1.0
        })
        
        UIView.animate(withDuration: 0.9, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.LogInButton.transform = CGAffineTransform.identity
            self.LogInButton.alpha = 1.0
        })
        
        UIView.animate(withDuration: 1.1, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.titleLabel.transform = CGAffineTransform.identity
            self.titleLabel.alpha = 1.0
        })
    }
    
    private func animateEverythingOut(completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: 0.8, animations: {
            self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height)
            self.titleLabel.alpha = 0.0
        })
        
        UIView.animate(withDuration: 0.8, delay: 0.1, animations: {
            self.userNameTextField.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height)
            self.userNameTextField.alpha = 0.0
        })
        
        UIView.animate(withDuration: 0.8, delay: 0.2, animations: {
            self.passwordTextField.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height)
            self.passwordTextField.alpha = 0.0
        })
        
        UIView.animate(withDuration: 0.8, delay: 0.3, animations: {
            self.LogInButton.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height)
            self.LogInButton.alpha = 0.0
        }, completion: completion)
    }
}
