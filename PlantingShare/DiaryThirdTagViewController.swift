//
//  DiaryThirdTagViewController.swift
//  PlantingShare
//
//  Created by 김준오 on 24/08/2019.
//  Copyright © 2019 lim. All rights reserved.
//

import UIKit

class DiaryThirdTagViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: - Properties
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchFooter: SearchFooter!
    
//    var detailViewController: DetailViewController? = nil
    var candies = [Candy]()
    var filteredCandies = [Candy]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        candies = [
            Candy(category:"Flower", name:"코스모스"),
            Candy(category:"Flower", name:"나팔꽃"),
            Candy(category:"Flower", name:"해바라기"),
            Candy(category:"Flower", name:"게발선인장"),
            Candy(category:"Flower", name:"과꽃"),
            Candy(category:"Flower", name:"메리골드"),
            Candy(category:"Flower", name:"데이지"),
            Candy(category:"Flower", name:"백일홍"),
            Candy(category:"Flower", name:"수선화"),
            Candy(category:"Flower", name:"팬지"),
            Candy(category:"Flower", name:"제비꽃"),
            Candy(category:"Flower", name:"개나리"),
            Candy(category:"Tree", name:"구상나무"),
            Candy(category:"Tree", name:"사과나무"),
            Candy(category:"Tree", name:"배나무"),
            Candy(category:"Tree", name:"구상나무"),
            Candy(category:"Tree", name:"소나무"),
            Candy(category:"Tree", name:"메타세쿼이아"),
            Candy(category:"Tree", name:"백합나무"),
            Candy(category:"Tree", name:"대나무"),
            Candy(category:"Tree", name:"자작나무"),
            Candy(category:"Tree", name:"감나무"),
            Candy(category:"Tree", name:"잣나무"),
            Candy(category:"Tree", name:"편백나무"),
        ]
        
        
        
//        if let splitViewController = splitViewController {
//            let controllers = splitViewController.viewControllers
//            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
//        if splitViewController!.isCollapsed {
//            if let selectionIndexPath = self.tableView.indexPathForSelectedRow {
//                self.tableView.deselectRow(at: selectionIndexPath, animated: animated)
//            }
//        }
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCandies = candies.filter({( candy : Candy) -> Bool in
            return candy.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    
    // MARK: - Segues
    //  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    if segue.identifier == "showDetail" {
    //      if let indexPath = tableView.indexPathForSelectedRow {
    //        let candy = candies[indexPath.row]
    //        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
    //        controller.detailCandy = candy
    //        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
    //        controller.navigationItem.leftItemsSupplementBackButton = true
    //      }
    //    }
    //  }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredCandies.count
        }
        return candies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let candy: Candy
        if isFiltering() {
            candy = filteredCandies[indexPath.row]
        } else {
            candy = candies[indexPath.row]
        }
        cell.textLabel!.text = candy.name
        cell.detailTextLabel!.text = candy.category
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 태그된 정보 저장
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DiaryThirdTagViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
