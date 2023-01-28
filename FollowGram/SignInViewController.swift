//
//  ViewController.swift
//  FollowGram
//
//  Created by shoeb on 25/01/23.
//

import UIKit
import Parse

class SignInViewController: UIViewController {
    
    @IBOutlet weak var usernameTFIN: UITextField!
    @IBOutlet weak var passwordTFIN: UITextField!
    @IBOutlet weak var signUpLBL: UILabel!
    @IBOutlet weak var forgotPasswordLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide Navigation Controller Back Button
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        //SignUpLBL Label Action Move Next Navigation Controller
        let tap = UITapGestureRecognizer(target: self, action: #selector(signUpFunc))
        signUpLBL.addGestureRecognizer(tap)
    }
    
    //SignIn Button Code Here Varification Code
    @IBAction func signInBTN(_ sender: Any) {
        if usernameTFIN.text != "" && passwordTFIN.text != ""{
            PFUser.logInWithUsername(inBackground: usernameTFIN.text!, password: passwordTFIN.text!){ (success, error) in
                if error != nil{
                    self.makeAlert(title: "Error", message: error!.localizedDescription )
                }else{
                    let alert = UIAlertController(title: "Successful", message: "Login successfully", preferredStyle: UIAlertController.Style.alert)
                    let okBTN = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel){ [self] (UIAlertAction) in
                        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                        self.navigationController?.pushViewController(homeVC, animated: true)
                    }
                    alert.addAction(okBTN)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }else{
            self.makeAlert(title: "Empty", message: "Please enter your data")
        }
    }
    
    //SignUpLBL Label Action Move Next Navigation Controller
    @objc func signUpFunc(){
        let SignUpCV = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(SignUpCV, animated: true)
    }
    
    //Alert Message Code Here
    func makeAlert(title : String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okBTN = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okBTN)
        self.present(alert, animated: true, completion: nil)
    }
}

