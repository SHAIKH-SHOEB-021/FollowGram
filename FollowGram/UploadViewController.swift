//
//  UploadViewController.swift
//  FollowGram
//
//  Created by shoeb on 27/01/23.
//

import UIKit
import Parse

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        uploadImage.addGestureRecognizer(gestureRecognizer)
    }
    
    //Upload Button Code Here
    @IBAction func uploadBTN(_ sender: Any) {
        if titleTextField.text != "" {
            let imageData = uploadImage.image?.jpegData(compressionQuality: 0.5)
            let file = PFFileObject(name: "\(titleTextField!.text!).png", data: imageData!)
            let object = PFObject(className: "posts")
            object["image"] = file
            object["title"] = titleTextField.text!
            object["username"] = PFUser.current()!.self as PFObject
            object.saveInBackground { (success, error) in
                if success {
                    print("Image has been saved.")
                } else {
                    print("Error: \(error?.localizedDescription ?? "")")
                }
            }
            
        }
        
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    @objc func chooseImage(){
        let pickerImage = UIImagePickerController()
        pickerImage.delegate = self
        pickerImage.sourceType = .photoLibrary
        self.present(pickerImage, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
}
