//
//  BoardThridViewController.swift
//  PlantingShare
//
//  Created by cscoi024 on 2019. 8. 23..
//  Copyright © 2019년 lim. All rights reserved.
//

import UIKit

class BoardThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postContentText: UITextView!
    
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var writeComment: UIButton!
    
    var postTitle: String!
    var postAuthor: String!
    var postDate: Date!
    var comments: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        commentTableView.dataSource = self
        commentTableView.delegate = self
        titleLabel.text = postTitle
        authorLabel.text = postAuthor
        
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "boards") else {
            print("fail to load board")
            return
    }
    
        let jsonData: Data = dataAsset.data
        let decoder: JSONDecoder = JSONDecoder()
        
        do {
            comments = try decoder.decode([Comment].self, from: jsonData)
        } catch {
            print("json decode failed")
        }
        
        commentTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Commentcell", for: indexPath)
        
        let comment : Comment = comments[indexPath.row]
        cell.detailTextLabel?.text = comment.comment
        cell.textLabel?.text = comment.id
        
        return cell
    }

    
    
}
