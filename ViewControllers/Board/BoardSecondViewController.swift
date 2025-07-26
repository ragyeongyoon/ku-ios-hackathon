//
//  BoardSecondViewController.swift
//  PlantingShare
//
//  Created by cscoi024 on 2019. 8. 23..
//  Copyright © 2019년 lim. All rights reserved.
//

import UIKit

class BoardSecondViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boards.count
    }

    @IBOutlet weak var boardTableView: UITableView!
    
    var boardSelect: String!
    var boardTitle: String!
    var boards : [PlantInfo] = []
    
    let dateFormatter: DateFormatter = {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let dataAsset : NSDataAsset = NSDataAsset(name: boardSelect) else {
            print("fail")
            return
        }
        let jsonData : Data = dataAsset.data
        let decoder : JSONDecoder = JSONDecoder()
        
        do{
            boards = try decoder.decode([PlantInfo].self, from: jsonData)
            boardTableView.delegate = self
            boardTableView.dataSource = self
            boardTableView.reloadData()
        } catch {
            print("json decode failed")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = boardTitle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! BoardPostTableViewCell
        
        let author: PlantInfo = boards[indexPath.row]
        cell.authorLabel?.text = author.postAuthor
        
        let title: PlantInfo = boards[indexPath.row]
        cell.titleLabel?.text = title.postTitle
        
        let date: Date = Date()
        let dateString: String = self.dateFormatter.string(from: date)
        cell.dateLabel.text = dateString
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? BoardPostTableViewCell else{
            print("sender가 PostTableViewCell이 아님")
            return
        }
        guard let nextViewController = segue.destination as? BoardThirdViewController else{
            print("목적지가 BoardThirdViewController가 아닙니다")
            return
        }
        guard let index: IndexPath = self.boardTableView.indexPath(for: cell) else {
            return
        }
        let info: PlantInfo = self.boards[index.row]
        
        nextViewController.postTitle = cell.titleLabel.text
        nextViewController.postAuthor = cell.authorLabel.text
        
        
        nextViewController.postDate = dateFormatter.date(from: cell.dateLabel.text!)
        
    }
    
    //추가한 내용
//    func loadContactsFromFile() {
//        let filePath = try! FileManager.default.url(for: .applicationSupportDirectory,
//                                                    in: .userDomainMask,
//                                                    appropriateFor: nil,
//                                                    create: false)
//            .appendingPathComponent("PlantInfo.json")
//        let jsonData: Data
//        do {
//            jsonData = try Data(contentsOf: filePath)
//        } catch {
//            print("load data 실패" + error.localizedDescription)
//            return
//        }
//        
//        let decoder: JSONDecoder = JSONDecoder()
//        do{
//            contents = try decoder.decode([PlantInfo].self, from: jsonData)
//            print("파일에서 불러온 친구 수 : \(contents.count)")
//        } catch {
//            print("decode json 실패" + error.localizedDescription)
//        }
//    }
//    
}
