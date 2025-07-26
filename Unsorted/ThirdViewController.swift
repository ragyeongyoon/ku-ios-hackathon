//
//  ThirdViewController.swift
//  plantingShare
//
//  Created by cscoi017 on 2019. 8. 26..
//  Copyright © 2019년 None. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAnalytics

class ThirdViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var database: DatabaseReference!
    var databaseHandler: DatabaseHandle!
    let storage1 = Storage.storage()
    
    
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var idSignField: UITextField!
    @IBOutlet var pwSignField: UITextField!
    @IBOutlet var pwConfirmField: UITextField!
    @IBOutlet var idSignLabel: UILabel!
    @IBOutlet var pwSignLabel: UILabel!
    @IBOutlet var pwConfirmLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var cancel1Button: UIButton!
    var all: Bool = false
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        UIPinchGestureRecognizer.accessibilityActivate()
        return picker
    }()
    
    @IBAction func cancel2 ( _ sender: UIButton) {
        IdPassword.shared.id = nil
        IdPassword.shared.pw = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    func addPictureOnStorage () {
        let data = UIImagePNGRepresentation(self.profileImage.image!)
        
        
        
        let storageRef = storage1.reference()
        if let identi = idSignField.text {
        
        
        var profilePath = storageRef.child("images/\(identi).png")
        if let data1 = data {
        let uploadTask = profilePath.putData(data1, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                print("upload 에러")
                return
            }
        }
        }
        }
    }
    
    
    func addNewAccount (userId: String, userPw: String ) {
        database = Database.database().reference()
        
        let childUpdates = ["/authentication/\(userId)":["pw":userPw]]
        database.updateChildValues(childUpdates)
    }
    func fillAll() {
        if let t1 = idSignField.text, let t2 = pwSignField.text, let t3 = pwConfirmField.text, t1.count > 0, t2.count > 0, t3.count > 0, t2 == t3, all == true {
            nextButton.isEnabled = true
        }
    }
    @IBAction func textFieldFilled(_ sender: UITextField) {
        fillAll()
    }
    
    @IBAction func nextAndSendingToServer(_ sender: UIButton) {
        if let id = idSignField.text, let pw = pwSignField.text {
            addNewAccount( userId: id, userPw: pw)
        }
        addPictureOnStorage()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    @IBAction func touchUpSelectImageButton(_ sender: UITapGestureRecognizer) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated:true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])  {
        if let editedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.profileImage.image = editedImage
            
            
        }
        self.dismiss(animated: true, completion:nil)
        all = true
        fillAll()
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

