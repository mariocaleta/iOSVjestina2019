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
            (acessToken) in
            DispatchQueue.main.async {
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                if acessToken == nil{
                    self.displayMessage(userMessage: "Korisničko ime ili šifra su netočni. Molimo vas pokušajte ponovno.")
                }else{
                    let userDefaults = UserDefaults.standard
                    userDefaults.set(acessToken, forKey: "accessToken")
                    let vc = InitialViewController(nibName: "InitialViewController", bundle: nil)
                    self.present(vc, animated: true, completion: nil)
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
}
