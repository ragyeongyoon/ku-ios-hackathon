//
//  ManageViewController.swift
//  PlantingShare
//
//  Created by cscoi024 on 2019. 8. 23..
//  Copyright © 2019년 lim. All rights reserved.
//

import UIKit

class ManageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!
    var plants: [PlantInfo2] = []
    var manager: [ManageInfo] = []
    
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

        tableView.delegate = self
        tableView.dataSource = self
        
        let decoder: JSONDecoder = JSONDecoder()
       
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "data") else {
            print("data asset 가져올 수 없음")
            return
        }
        
        let jsonData: Data = dataAsset.data
        
        do {
            manager = try decoder.decode(([ManageInfo].self), from: jsonData)
        } catch {
            print("json decoding 실패 : ", error.localizedDescription)
        }
        
        print("\(manager.count)개 식물정보 불러옴")

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPlantsFromFile()
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlantnNameTableViewCell
        
        let plant: PlantInfo2 = plants[indexPath.row]
        cell.plantName.text = plant.plantName
        

        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle.delete
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            let filePath = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("plants.json")
            
            do {
                plants.remove(at: indexPath.row)
                let encoder: JSONEncoder = JSONEncoder()
                let jsonData = try encoder.encode(plants)
                try jsonData.write(to: filePath)
                
                tableView.reloadSections(IndexSet(0...0), with: UITableViewRowAnimation.automatic)
                
            } catch {
                print("reset실패 " + error.localizedDescription)
            }

            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let nextViewController = segue.destination as? ManageSecondViewController else {
            print("destination is not SecondViewController")
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        
        guard let index: IndexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        let plant: PlantInfo2 = plants[index.row]
        
        nextViewController.plantNameVariable = plant.plantName
        nextViewController.plantImageVariable = index.row
        nextViewController.manage = manager[index.row]
        
        
        
        
        
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
