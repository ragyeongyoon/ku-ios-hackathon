//
//  ManageThirdViewController.swift
//  PlantingShare
//
//  Created by cscoi024 on 2019. 8. 23..
//  Copyright © 2019년 lim. All rights reserved.
//

import UIKit

class ManageThirdViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        return picker
    }()
    
    
    @IBOutlet var forRegistImageView: UIImageView!
    @IBOutlet var forRegistPlantNameTextField: UITextField!
    var plants: [PlantInfo2] = []
    
    @IBAction func touchUpAddButton(_ sender: UIButton) {
        let newPlant: PlantInfo2 = PlantInfo2()
//        newPlant.plantImage = forRegistImageView.image
        newPlant.plantName = forRegistPlantNameTextField.text
        plants.append(newPlant)
        savePlantsToFile()
        
        self.dismiss(animated: true,
                     completion:nil)
    
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true,
                     completion:nil)
    }
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    @IBAction func touchUpSelectImageButton(_ sender: UITapGestureRecognizer) {
        self.present(self.imagePicker, animated: true, completion:  nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let originalImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            self.forRegistImageView.image = originalImage
            
        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func savePlantsToFile() {
        let encoder: JSONEncoder = JSONEncoder()
        let jsonData: Data
        do {
            jsonData = try encoder.encode(plants)
        } catch {
            print("encoding is failed" + error.localizedDescription)
            return
        }
        
        let filePath = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("plants.json")
        
        do {
            try jsonData.write(to: filePath)
        } catch {
            print("writing to path is failed " + error.localizedDescription)
            return
        }
        print("저장 완료. 현재 저장된 식물 수 : \(plants.count)")
    }
    
    
    func loadPlantsFromFile() {
        
        let filePath = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("plants.json")
        let jsonData: Data
        do {
            jsonData = try Data(contentsOf: filePath)
        } catch {
            print("load data 실패 " + error.localizedDescription)
            return
        }
        let decoder: JSONDecoder = JSONDecoder()
        do {
            plants = try decoder.decode([PlantInfo2].self, from: jsonData)
            print("파일에서 불러온 식물 수 : \(plants.count)")
        } catch {
            print("decode json 실패 " + error.localizedDescription)
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlantsFromFile()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        
        
        let alert =  UIAlertController(title : nil , message: nil , preferredStyle: .actionSheet)
        
        
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
            
        }
        
        
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            
            self.openCamera()
            
        }
        
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        
        alert.addAction(library)
        
        alert.addAction(camera)
        
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func openLibrary(){
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: false, completion: nil)
        
    }
    
    func openCamera(){
        
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            
            imagePicker.sourceType = .camera
            
            present(imagePicker, animated: false, completion: nil)
            
        }
            
        else{
            
            print("Camera not available")
            
        }
        
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
