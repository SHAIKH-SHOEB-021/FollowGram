//
//  HomeViewController.swift
//  FollowGram
//
//  Created by shoeb on 27/01/23.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var homeTableView: UITableView!
    var postNameArray = [String]()
    var postIDArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain,target: self,action: #selector(logoutBarFunc))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(uploadBarFunc))
        homeTableView.dataSource = self
        homeTableView.delegate = self
        getDataFromParse()
    }
    
    func getDataFromParse(){
        let query = PFQuery(className: "posts")
        query.findObjectsInBackground{ (objects, error) in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okBTN = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okBTN)
                self.present(alert, animated: true, completion: nil)
            }else{
                if objects != nil{
                    self.postIDArray.removeAll(keepingCapacity: false)
                    self.postNameArray.removeAll(keepingCapacity: false)
                    for object in objects! {
                        if let postName = object.object(forKey: "title") as? String{
                            if let postID = object.objectId{
                                self.postNameArray.append(postName)
                                self.postIDArray.append(postID)
                            }
                        }
                    }
                    self.homeTableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCell = homeTableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath)
        homeCell.textLabel?.text = postNameArray[indexPath.row]
        return homeCell
    }
    
    @objc func logoutBarFunc(){
        PFUser.logOutInBackground{ (error) in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okBTN = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okBTN)
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Logout", message: "Logout your account", preferredStyle: UIAlertController.Style.alert)
                let okBTN = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (UIAlertAction) in
                    let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                    self.navigationController?.pushViewController(homeVC, animated: true)
                }
                let cancelBTN = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okBTN)
                alert.addAction(cancelBTN)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    @objc func uploadBarFunc(){
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "UploadViewController") as! UploadViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}
