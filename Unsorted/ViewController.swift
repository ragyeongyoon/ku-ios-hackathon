//
//  ViewController.swift
//  plantingShare
//
//  Created by cscoi017 on 2019. 8. 26..
//  Copyright © 2019년 None. All rights reserved.
//

import UIKit

import FirebaseDatabase
import FirebaseStorage

class ViewController: UIViewController {
    var database: DatabaseReference!
    var IdPasswordInf: [String:[String:String]]! = [:]
    var databaseHandler: DatabaseHandle!
    @IBOutlet var alertMessage: UILabel!
    @IBOutlet var myTabBarController: UITabBarController!
    let databaseName: String = "authentication"
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var logInButton: UIButton!
    @IBAction func checkServer (_ sender: UIButton) {
        IdPassword.shared.id = nil
        IdPassword.shared.pw = nil
        
        for Count in (0...self.IdPasswordInf.count-1) {
            
            
            if Array(self.IdPasswordInf)[Count].key == idTextField.text {
                IdPassword.shared.id = idTextField.text
                if Array(self.IdPasswordInf)[Count].value["pw"] == pwTextField.text {
                    
                    IdPassword.shared.pw = pwTextField.text
                    
                }
            }
        }
        if IdPassword.shared.id == nil {
            alertMessage.text = "아이디가 없습니다."
            
        } else if IdPassword.shared.id != nil, IdPassword.shared.pw == nil {
            alertMessage.text = "패스워드가 틀립니다."
        } else {
            alertMessage.text = "환영합니다. \(IdPassword.shared.id)님"
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TapBar") as! SecondViewController
            
//            present(vc, animated:  true , completion: nil)
            performSegue(withIdentifier: "ShowMainTab", sender: sender)
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    func configureDatabase() {
        database = Database.database().reference()
        databaseHandler = database.child(databaseName).observe(.value, with: { (snapshot)-> Void in guard let IdPasswordInf = snapshot.value as? [String:[String:String]] else {
            return
            }
            
            self.IdPasswordInf = IdPasswordInf
            print("새로운 Id가 추가되었습니다")
            print("\(self.IdPasswordInf.count)개")
            
            
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatabase()
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
