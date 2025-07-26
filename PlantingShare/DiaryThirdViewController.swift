//
//  DiaryThirdViewController.swift
//  PlantingShare
//
//  Created by 김준오 on 23/08/2019.
//  Copyright © 2019 lim. All rights reserved.
//

import UIKit

class DiaryThirdViewController: UIViewController {
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var postField: UITextField!
    
    var selectedImage: UIImage!
    var posts: [Post] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.imageView.image = self.selectedImage
        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchUpAddButton(_ sender: Any) {
        let newPost: Post = Post()
        newPost.name = "준오"
        newPost.date = Date() // 지금 이 순간
//        newPost.postImage = imageView.image
        newPost.postContent = postField.text
        posts.append(newPost)
        savePostsToFile()
        self.dismiss(animated: true, completion: nil)    }
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func savePostsToFile() {
        let encoder: JSONEncoder = JSONEncoder()
        let jsonData: Data
        do {
            jsonData = try encoder.encode(posts)
        } catch {
            print("encode 실패 " + error.localizedDescription)
            return
        }
        
        let filePath = try! FileManager.default.url(for: .applicationSupportDirectory,
                                                    in: .userDomainMask,
                                                    appropriateFor: nil,
                                                    create: true)
            .appendingPathComponent("posts.json")
        
        do {
            try jsonData.write(to: filePath)
        } catch {
            print("write to path 실패 " + error.localizedDescription)
            return
        }
        print("저장 완료. 현재 저장된 게시물 수 : \(posts.count)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: DiaryViewController =
            segue.destination as? DiaryViewController else {
                return
        }
        nextViewController.posts = self.posts
    }
//    func loadPostsFromFile() {
//        let filePath = try! FileManager.default.url(for: .applicationSupportDirectory,
//                                                    in: .userDomainMask,
//                                                    appropriateFor: nil,
//                                                    create: false)
//            .appendingPathComponent("posts.json")
//
//        let jsonData: Data
//        do {
//            jsonData = try Data(contentsOf: filePath)
//        } catch {
//            print("load data 실패 " + error.localizedDescription)
//            return
//        }
//        let decoder: JSONDecoder = JSONDecoder()
//        do {
//            posts = try decoder.decode([Post].self, from: jsonData)
//            print("파일에서 불러온 게시물 수 : \(posts.count)")
//        } catch {
//            print("decode json 실패 " + error.localizedDescription)
//        }
//    }
    
//    @IBAction func abc(_ sender: UISwitch) {
//        
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
