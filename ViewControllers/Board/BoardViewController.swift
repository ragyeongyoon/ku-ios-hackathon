//
//  BoardViewController.swift
//  PlantingShare
//
//  Created by cscoi024 on 2019. 8. 23..
//  Copyright © 2019년 lim. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var boardTableView: UITableView!
    var boardsets: [BoardSet] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        boardTableView.delegate = self
        boardTableView.dataSource = self
        self.navigationItem.title = "boardSet"
        
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "boards") else {
            print("fail to load board")
            return
        }
    
    let jsonData: Data = dataAsset.data
    let decoder: JSONDecoder = JSONDecoder()
    
    do {
        boardsets = try decoder.decode([BoardSet].self, from: jsonData)
    } catch {
    print("json decode failed")
    }
        
    boardTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boardsets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Boardcell", for: indexPath) as! BoardTableViewCell
        let boardset : BoardSet = boardsets[indexPath.row]
        
        cell.titleLabel?.text = boardset.boardName
        cell.detailLabel?.text = boardset.boardDetail
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell else {
            print("sender is not cell")
            return
        }
        guard let nextViewController = segue.destination as? BoardSecondViewController
            else {
                print("destination is not BoardSecondViewController")
                return
        }
        guard let index: IndexPath = self.boardTableView.indexPath(for: cell) else {
            return
        }
        
        let info: BoardSet = self.boardsets[index.row]
        
        nextViewController.boardSelect = info.assetName
        nextViewController.boardTitle = info.boardName
    }
    
    
}
