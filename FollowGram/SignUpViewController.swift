//
//  SignUpViewController.swift
//  FollowGram
//
//  Created by shoeb on 25/01/23.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signInLBL: UILabel!
    let user = PFUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide Navigation Controller Back Button
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        //SignInLBL Label Action Move Next Navigation Controller
        let tap = UITapGestureRecognizer(target: self, action: #selector(signInFunc))
        signInLBL.addGestureRecognizer(tap)
       
    }
    
    //SignUp Button Code Here Save Data in Server
    @IBAction func signUpBTN(_ sender: Any) {
        if usernameTF.text != "" && emailTF.text != "" && passwordTF.text != "" {
            user.username = usernameTF.text!
            user.password = passwordTF.text!
            user.email = emailTF.text!
            user.signUpInBackground{ (success, error) in
                if error != nil{
                    let alert = UIAlertController(title: "Error", message: error!.localizedDescription , preferredStyle: UIAlertController.Style.alert)
                    let okBTN = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okBTN)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Successfull", message: "Data has been save in server", preferredStyle: UIAlertController.Style.alert)
                    let okBTN = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel){ (UIAlertAction) in
                        let VC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                        self.navigationController?.pushViewController(VC, animated: true)
                    }
                    alert.addAction(okBTN)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }else{
            let alert = UIAlertController(title: "Empty", message: "Please enter your data", preferredStyle: UIAlertController.Style.alert)
            let okBTN = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okBTN)
            self.present(alert, animated: true, completion: nil)
        }
    }
    @objc func signInFunc(){
        let SignInCV = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        self.navigationController?.pushViewController(SignInCV, animated: true)
    }
}
