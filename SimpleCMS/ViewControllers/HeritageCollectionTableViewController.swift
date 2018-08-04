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
    private var seeder = Seeder()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var heritageCollectionTableView: UITableView!
    var searchController : UISearchController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        heritageObjects = seeder.createHeritageObjects()
        setupSearchBar()
//        if #available(iOS 11.0, *) {
//            navigationController?.navigationBar.prefersLargeTitles = false
//            navigationItem.searchController = searchController
//        }
    }
    
//    override func viewDidLayoutSubviews() {
//        searchBar.sizeToFit()
//    }
    

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return heritageObjects.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "heritageCollectionCell", for: indexPath) as? HeritageObjectTableViewCell else {
            fatalError("Wrong TableViewCell")
        }
        // Configure the cell...
        cell.objectIdLabel?.text = heritageObjects[indexPath.row].id
        cell.objectTitleLabel?.text = heritageObjects[indexPath.row].name
        cell.objectCategoryLabel?.text = heritageObjects[indexPath.row].category.textualRepresentation
        cell.objectImageView?.image = heritageObjects[indexPath.row].photos.first as? UIImage
        return cell
    }
    
 

    // MARK: - Private methods
    
    private func setupSearchBar() {
        if let searchCategories = returnSortedCategoriesOfHeritageObjects() {
            searchBar.scopeButtonTitles = searchCategories
            searchBar.showsScopeBar = true
        } else {
            searchBar.showsScopeBar = false
        }
    }
    
    private func returnSortedCategoriesOfHeritageObjects() -> [String]? {
        if (!heritageObjects.isEmpty) {
            return Array(Set(heritageObjects.map{$0.category.textualRepresentation}).sorted{$0 < $1})
        } else {
            return nil
        }
    }

}
