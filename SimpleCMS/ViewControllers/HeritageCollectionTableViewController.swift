//
//  HeritageCollectionTableViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 2/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class HeritageCollectionTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var heritageObjects = [HeritageObject]()
    var currentHeritageObjects : [HeritageObject] = []
    private var seeder = Seeder()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var heritageCollectionTableView: UITableView!
    var searchController : UISearchController!
    var isSearching = false
    var categories: [HeritageObjectCategory] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        heritageObjects = seeder.createHeritageObjects()
        currentHeritageObjects = heritageObjects
        setupSearchBar()
        searchBar.delegate = self
    }
    

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentHeritageObjects.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "heritageCollectionCell", for: indexPath) as? HeritageObjectTableViewCell else {
            fatalError("Wrong TableViewCell")
        }
        // Configure the cell...
        cell.objectIdLabel?.text = currentHeritageObjects[indexPath.row].id
        cell.objectTitleLabel?.text = currentHeritageObjects[indexPath.row].name
        cell.objectCategoryLabel?.text = currentHeritageObjects[indexPath.row].category.textualRepresentation
        cell.objectImageView?.image = currentHeritageObjects[indexPath.row].photos.first as? UIImage
        return cell
    }
    
    // MARK: - Search bar methods
    // verbeteringen: first responder searchbar + stoppen highlighten scopte
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentHeritageObjects = heritageObjects
            heritageCollectionTableView.reloadData()
            return
        }
        currentHeritageObjects = heritageObjects.filter{ object -> Bool in
            return object.name.lowercased().contains(searchText.lowercased())
                || object.id.lowercased().contains(searchText.lowercased())
        }
        heritageCollectionTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        categories = returnSortedSCategoriesOfHeritageObjects()
        if (categories.count < 2 || categories.count > 5 ) {
            fatalError("te weinig of veel categorieën")
        } else {
            switch selectedScope {
            case 0:
                currentHeritageObjects = heritageObjects.filter{ $0.category == categories[0] }
            case 1:
                currentHeritageObjects = heritageObjects.filter{ $0.category == categories[1] }
            case 2:
                if (categories.count < 3) {
                    fatalError("deze scope kan er niet staan") }
                currentHeritageObjects = heritageObjects.filter { $0.category == categories[2] }
            case 3:
                if (categories.count < 4) {
                    fatalError("deze scope kan er niet staan") }
                currentHeritageObjects = heritageObjects.filter { $0.category == categories[3] }
            default:
                currentHeritageObjects = heritageObjects
                    
            }
            heritageCollectionTableView.reloadData()
        }
    }
    
 

    // MARK: - Private methods
    
    private func setupSearchBar() {
        let searchCategories = returnSortedStringCategoriesOfHeritageObjects()
        if (searchCategories.count > 1 && searchCategories.count < 5) {
            // scopebar with more than 5 items will be too big; with only 1 item it's pointless
            searchBar.scopeButtonTitles = searchCategories
            searchBar.showsScopeBar = true
        } else {
            searchBar.showsScopeBar = false
        }
    }
    
    private func returnSortedStringCategoriesOfHeritageObjects() -> [String] {
        let categories = returnSortedSCategoriesOfHeritageObjects()
        return categories.map{$0.textualRepresentation}
        
    }
    
    private func returnSortedSCategoriesOfHeritageObjects() -> [HeritageObjectCategory] {
        return Array(Set(heritageObjects.map{$0.category}).sorted{$0.textualRepresentation < $1.textualRepresentation})
        
    }

}
