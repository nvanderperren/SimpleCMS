//
//  HeritageCollectionTableViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 2/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class HeritageCollectionTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITextFieldDelegate {
    
    // MARK: - Properties
    var heritageObjects = [HeritageViewModel]()
    var currentHeritageObjects : [HeritageViewModel] = []
    private var seeder = Seeder()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var heritageCollectionTableView: UITableView!
    var isSearching = false
    var categories: [String] = []

    // MARK: - ViewController method
    override func viewDidLoad() {
        super.viewDidLoad()
        heritageObjects = seeder.heritageObjects.sorted{$0.id < $1.id  }
        //currentHeritageObjects = heritageObjects
        categories = returnSortedCategoriesOfHeritageObjects()
        setupSearchBar()
    }
    
    // MARK: - Navigation - Unwind Segues
    @IBAction func unwindFromFindToHeritageCollection(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? FindDetailViewController, let findObject = sourceViewController.find {
           addNewRowToTableView(with: findObject)
        }
    }
    
    @IBAction func unwindFromArtefactToHeritageCollection(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? ArtefactDetailViewController, let artefactObject = sourceViewController.artefact {
            addNewRowToTableView(with: artefactObject)
        }
    }
    
    @IBAction func unwindFromMonumentToHeritageCollection(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? MonumentDetailViewController, let monumentObject = sourceViewController.monument {
            addNewRowToTableView(with: monumentObject)
        }
    }
    
    @IBAction func unwindFromPublicationToHeritageCollection(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? PublicationDetailViewController, let publicationObject = sourceViewController.publication {
            addNewRowToTableView(with: publicationObject)
        }
    }
    

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
        cell.objectCategoryLabel?.text = heritageObjects[indexPath.row].category
        cell.objectImageView?.image = heritageObjects[indexPath.row].picture ?? UIImage(named: "defaultPhoto")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = heritageCollectionTableView.cellForRow(at: indexPath) as? HeritageObjectTableViewCell else {
            fatalError("Wrong TableViewCell")
        }
        switch(cell.objectCategoryLabel.text){
        case HeritageObjectCategory.artefact.rawValue:
            performSegue(withIdentifier: "Show artefact", sender: HeritageCollectionTableViewController())
        case HeritageObjectCategory.monument.rawValue:
            performSegue(withIdentifier: "Show monument", sender: HeritageCollectionTableViewController())
        case HeritageObjectCategory.metalDetectingFind.rawValue:
            performSegue(withIdentifier: "Show find", sender: HeritageCollectionTableViewController())
        case HeritageObjectCategory.publication.rawValue:
            performSegue(withIdentifier: "Show publication", sender: HeritageCollectionTableViewController())
        default:
            print("Problemen!")
        }
    }
    
    // MARK: - Search bar methods
    // verbeteringen: first responder searchbar + stoppen highlighten scopte
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
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
        
        categories = returnSortedCategoriesOfHeritageObjects()
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsScopeBar = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        currentHeritageObjects = heritageObjects
        heritageCollectionTableView.reloadData()
        searchBar.showsCancelButton = true
        setupScopeButtons()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentHeritageObjects = heritageObjects
        heritageCollectionTableView.reloadData()
        searchBar.showsScopeBar = false
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
        case "Show artefact":
            let destinationController = segue.destination as! ArtefactDetailViewController
            let selection = heritageCollectionTableView.indexPathForSelectedRow!
            destinationController.artefact = heritageObjects[selection.row] as? ArtefactViewModel
            heritageCollectionTableView.deselectRow(at: selection, animated: true)
        case "Show find":
            let destinationController = segue.destination as! FindDetailViewController
            let selection = heritageCollectionTableView.indexPathForSelectedRow!
            destinationController.find = heritageObjects[selection.row] as? FindViewModel
            heritageCollectionTableView.deselectRow(at: selection, animated: true)
        case "Show monument":
            let destinationController = segue.destination as! MonumentDetailViewController
            let selection = heritageCollectionTableView.indexPathForSelectedRow!
            destinationController.monument = heritageObjects[selection.row] as? MonumentViewModel
            heritageCollectionTableView.deselectRow(at: selection, animated: true)
        case "Show publication":
            let destinationController = segue.destination as! PublicationDetailViewController
            let selection = heritageCollectionTableView.indexPathForSelectedRow!
            destinationController.publication = heritageObjects[selection.row] as? PublicationViewModel
            heritageCollectionTableView.deselectRow(at: selection, animated: true)
        default:
            print("Segue does not exist")
        }
    }

    // MARK: - Private methods
    
    private func setupSearchBar() {
        searchBar.delegate = self
    }
    
    private func setupScopeButtons() {
        let searchCategories = categories.map{$0}
        if (searchCategories.count > 1 && searchCategories.count < 5) {
            // scopebar with more than 5 items will be too big; with only 1 item it's pointless
            searchBar.scopeButtonTitles = searchCategories
            searchBar.showsScopeBar = true
        } else {
            searchBar.showsScopeBar = false
        }
    }
    
    private func returnSortedCategoriesOfHeritageObjects() -> [String] {
        return Array(Set(heritageObjects.map{$0.category}).sorted{$0 < $1})
        
    }
    
    private func addNewRowToTableView(with record: HeritageViewModel){
        DatabaseService.service.create(record)
        let newIndexPath = IndexPath(row: heritageObjects.count-1, section: 0)
        heritageObjects.append(record)
        heritageCollectionTableView.insertRows(at: [newIndexPath], with: .automatic)
        for object in heritageObjects {
            print(object.name)
        }
    }

}
