//
//  BoardWritingViewController.swift
//  PlantingShare
//
//  Created by cscoi024 on 2019. 8. 23..
//  Copyright © 2019년 lim. All rights reserved.
//

import UIKit

class BoardWritingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var boardPicker: UIPickerView!
    var pickerData: [String] = [String]()
    var contents: [PlantInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = ["일상공유","질문답변","식물정보","알뜰장터","자연탐방"]
        boardPicker.delegate = self
        boardPicker.dataSource = self
        
//        idField.delegate = self
//        passwordField.delegate = self
//        titleField.delegate = self
//        PostView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @available(iOS 2.0, *)
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var PostView: UITextView!
    @IBOutlet var submitButton: UIButton!
    
    @IBAction func dismissSelf() {
        self.dismiss(animated: true,
                     completion: nil)}
    
    
    @IBAction func touchUpSetButton(_ sender: UIButton) {
        PlantInfo.shared.postAuthor = idField.text
        PlantInfo.shared.postTitle = titleField.text
        PlantInfo.shared.postContent = PostView.text
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController의 view가 회면에 보여질 예정")
        idField.text = PlantInfo.shared.postAuthor
        titleField.text = PlantInfo.shared.postTitle
        PostView.text = PlantInfo.shared.postContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController의 view가 화면에서 사라질 예정")
        PlantInfo.shared.postAuthor = idField.text
        PlantInfo.shared.postTitle = titleField.text
        PlantInfo.shared.postContent = PostView.text
    
        func textViewDidChange(_ textView: UITextView) {
            determineButtonState()}
        
        func determineButtonState() {
            if let id: String  = idField.text, id.count > 0,
                let password: String = passwordField.text, password.count > 0 {
                submitButton.isEnabled = true
            } else {
                submitButton.isEnabled = false}
            
        }}
    
    var dateFormatter: DateFormatter {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }
    
    @IBAction func touchUpAddButton(_sender: UIButton) {
        let newPost: PlantInfo = PlantInfo()
        newPost.postAuthor = idField.text
        newPost.postTitle = titleField.text
        newPost.postContent = PostView.text
        
        let date: Date = Date()
        let dateString: String = self.dateFormatter.string(from: date)
        newPost.postDate = dateString // 지금 이 순간
        
        contents.append(newPost)
        saveContactsToFile()
    }
    func saveContactsToFile() {
        let encoder: JSONEncoder = JSONEncoder()
        let jsonData: Data
        do {
            jsonData = try encoder.encode(contents)
        } catch {
            print("encode 실패" + error.localizedDescription)
            return
        }
        let filePath = try! FileManager.default.url(for: .applicationSupportDirectory,
                                                    in: .userDomainMask,
                                                    appropriateFor: nil,
                                                    create: true)
            .appendingPathComponent("PlantInfo.json")
        
        do {
            try jsonData.write(to: filePath)
        } catch {
            print("write to path 실패" + error.localizedDescription)
            return
        }
        print("저장 완료. 현재 저장된 게시물 수 : \(contents.count)")
        
    }
    
    func loadContactsFromFile() {
        let filePath = try! FileManager.default.url(for: .applicationSupportDirectory,
                                                    in: .userDomainMask,
                                                    appropriateFor: nil,
                                                    create: true)
            .appendingPathComponent("Contents.json")
        let jsonData: Data
        do {
            jsonData = try Data(contentsOf: filePath)
        } catch {
            print("load data 실패" + error.localizedDescription)
            return
        }
        
        let decoder: JSONDecoder = JSONDecoder()
        do{
            contents = try decoder.decode([PlantInfo].self, from: jsonData)
            print("파일에서 불러온 게시물 수 : \(contents.count)")
        } catch {
            print("decode json 실패" + error.localizedDescription)
        }
    }
    

}
