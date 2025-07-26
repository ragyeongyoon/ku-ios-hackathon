//
//  DiaryViewController.swift
//  PlantingShare
//
//  Created by cscoi024 on 2019. 8. 23..
//  Copyright © 2019년 lim. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var posts: [Post] = []
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
//        tableView.reloadData()
        // Do any additional setup after loading the view.
        
        
        let filePath = try! FileManager.default.url(for: .applicationSupportDirectory,
                                                    in: .userDomainMask,
                                                    appropriateFor: nil,
                                                    create: false)
            .appendingPathComponent("posts.json")
        
        let jsonData: Data
        do {
            jsonData = try Data(contentsOf: filePath)
        } catch {
            print("load data 실패 " + error.localizedDescription)
            return
        }
        let decoder: JSONDecoder = JSONDecoder()
        
        do {
            posts = try decoder.decode([Post].self, from: jsonData)
        } catch {
            print("json decode failed" + error.localizedDescription)
        }
        print("포스트 \(posts.count)개 로드됨")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let filePath = try! FileManager.default.url(for: .applicationSupportDirectory,
                                                    in: .userDomainMask,
                                                    appropriateFor: nil,
                                                    create: false)
            .appendingPathComponent("posts.json")
        
        let jsonData: Data
        do {
            jsonData = try Data(contentsOf: filePath)
        } catch {
            print("load data 실패 " + error.localizedDescription)
            return
        }
        let decoder: JSONDecoder = JSONDecoder()
        
        do {
            posts = try decoder.decode([Post].self, from: jsonData)
        } catch {
            print("json decode failed" + error.localizedDescription)
        }
        print("포스트 \(posts.count)개 로드됨")
        
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        
        let post: Post = posts[posts.count - indexPath.row - 1]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        cell.nameLabel.text = post.name
        cell.dateLabel.text = dateFormatter.string(for: post.date)
//        cell.postImageView.image = NSDataAsset.
        cell.postTextLabel.text = post.postContent
        
        return cell
    }
    
        func loadPostsFromFile() {
            let filePath = try! FileManager.default.url(for: .applicationSupportDirectory,
                                                        in: .userDomainMask,
                                                        appropriateFor: nil,
                                                        create: false)
                .appendingPathComponent("posts.json")
    
            let jsonData: Data
            do {
                jsonData = try Data(contentsOf: filePath)
            } catch {
                print("load data 실패 " + error.localizedDescription)
                return
            }
            let decoder: JSONDecoder = JSONDecoder()
            do {
                posts = try decoder.decode([Post].self, from: jsonData)
                print("파일에서 불러온 게시물 수 : \(posts.count)")
            } catch {
                print("decode json 실패 " + error.localizedDescription)
            }
        }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navi = segue.destination as? UINavigationController else {
            return
        }
        guard let nextViewController: DiarySecondViewController =
            navi.viewControllers.first as? DiarySecondViewController else {
                return
        }
        nextViewController.posts = self.posts
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
