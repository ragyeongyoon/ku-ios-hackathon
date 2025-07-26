//
//  DiaryThirdLocationViewController.swift
//  PlantingShare
//
//  Created by 김준오 on 24/08/2019.
//  Copyright © 2019 lim. All rights reserved.
//

import UIKit

class DiaryThirdLocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: - Properties
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchFooter: SearchFooter!
    
    //    var detailViewController: DetailViewController? = nil
    var locations = [Location]()
    var filteredLocations = [Location]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Location..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        locations = [
            Location(category:"서울", name:"성북구"),
            Location(category:"서울", name:"동대문구"),
            Location(category:"서울", name:"용산구"),
            Location(category:"서울", name:"성동구"),
            Location(category:"서울", name:"관악구"),
            Location(category:"서울", name:"서초구"),
            Location(category:"서울", name:"강남구"),
            Location(category:"서울", name:"금천구"),
            Location(category:"서울", name:"서대문구"),
            Location(category:"서울", name:"노원구"),
            Location(category:"서울", name:"중랑구"),
            Location(category:"서울", name:"도봉구"),
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
        filteredLocations = locations.filter({( location : Location) -> Bool in
            return location.name.lowercased().contains(searchText.lowercased())
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
            return filteredLocations.count
        }
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let location: Location
        if isFiltering() {
            location = filteredLocations[indexPath.row]
        } else {
            location = locations[indexPath.row]
        }
        cell.textLabel!.text = location.name
        cell.detailTextLabel!.text = location.category
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

extension DiaryThirdLocationViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
