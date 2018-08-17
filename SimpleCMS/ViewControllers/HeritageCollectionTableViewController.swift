//
//  HeritageCollectionTableViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 2/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class HeritageCollectionTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITextFieldDelegate {
    
    // MARK: - Properties and outlets
    var heritageObjects = [HeritageViewModel]()
    var currentHeritageObjects : [HeritageViewModel] = []
    private var seeder = Seeder()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var heritageCollectionTableView: UITableView!
    var isSearching = false
    var categories: [String] = []
    private var indexPathToEdit: IndexPath!

    // MARK: - ViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        heritageObjects = seeder.heritageObjects.sorted{$0.id < $1.id  }
        currentHeritageObjects = heritageObjects
        categories = returnSortedCategoriesOfHeritageObjects()
        setupSearchBar()
        heritageCollectionTableView.reloadData()
    }
    
    // MARK: - Navigation
    
    // MARK: Unwind Segues
    @IBAction func unwindFromFindToHeritageCollection(_ segue: UIStoryboardSegue){
        switch (segue.identifier) {
        case "did add find":
            if let sourceViewController = segue.source as? FindDetailViewController, let findObject = sourceViewController.find {
                addNewRowToTableView(with: findObject)
            }
        case "did edit find":
            heritageObjects = seeder.heritageObjects
            currentHeritageObjects = heritageObjects
            heritageCollectionTableView.reloadRows(at: [indexPathToEdit], with: .automatic)
        default:
            fatalError("Something went wrong!")
        }
    }
    
    @IBAction func unwindFromArtefactToHeritageCollection(_ segue: UIStoryboardSegue){
        switch (segue.identifier) {
        case "did add artefact":
                if let sourceViewController = segue.source as? ArtefactDetailViewController, let artefactObject = sourceViewController.artefact {
                    addNewRowToTableView(with: artefactObject)
            }
        case "did edit artefact":
            heritageCollectionTableView.reloadRows(at: [indexPathToEdit], with: .automatic)
        default:
            fatalError("Something went wrong!")
        }
    }
    
    @IBAction func unwindFromMonumentToHeritageCollection(_ segue: UIStoryboardSegue){
        switch (segue.identifier) {
        case "did add monument":
            if let sourceViewController = segue.source as? MonumentDetailViewController, let monumentObject = sourceViewController.monument {
                addNewRowToTableView(with: monumentObject)
            }
        case "did edit monument":
            heritageCollectionTableView.reloadRows(at: [indexPathToEdit], with: .automatic)
        default:
            fatalError("Something went wrong!")
        }
    }
    
    @IBAction func unwindFromPublicationToHeritageCollection(_ segue: UIStoryboardSegue){
        switch (segue.identifier) {
        case "did add publication":
            if let sourceViewController = segue.source as? PublicationDetailViewController, let publicationObject = sourceViewController.publication {
                addNewRowToTableView(with: publicationObject)
            }
        case "did edit publication":
            heritageCollectionTableView.reloadRows(at: [indexPathToEdit], with: .automatic)
        default:
            fatalError("Something went wrong!")
        }
    }
    
    // MARK: Segue to other viewcontrollers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
        case "show artefact":
            let destinationController = segue.destination as! ArtefactDetailViewController
            if let selection = heritageCollectionTableView.indexPathForSelectedRow {
                destinationController.artefact = heritageObjects[selection.row] as? ArtefactViewModel
                heritageCollectionTableView.deselectRow(at: selection, animated: true)
            } else {
                destinationController.artefact = heritageObjects[indexPathToEdit.row] as? ArtefactViewModel
            }
        case "show find":
            let destinationController = segue.destination as! FindDetailViewController
            if let selection = heritageCollectionTableView.indexPathForSelectedRow {
                destinationController.find = heritageObjects[selection.row] as? FindViewModel
                heritageCollectionTableView.deselectRow(at: selection, animated: true)
            } else {
                destinationController.find = heritageObjects[indexPathToEdit.row] as? FindViewModel
            }
        case "show monument":
            let destinationController = segue.destination as! MonumentDetailViewController
            if let selection = heritageCollectionTableView.indexPathForSelectedRow {
                destinationController.monument = heritageObjects[selection.row] as? MonumentViewModel
                heritageCollectionTableView.deselectRow(at: selection, animated: true)
            } else {
                destinationController.monument = heritageObjects[indexPathToEdit.row] as? MonumentViewModel
            }
        case "show publication":
            let destinationController = segue.destination as! PublicationDetailViewController
            if let selection = heritageCollectionTableView.indexPathForSelectedRow {
                destinationController.publication = heritageObjects[selection.row] as? PublicationViewModel
                heritageCollectionTableView.deselectRow(at: selection, animated: true)
            } else {
                destinationController.publication = heritageObjects[indexPathToEdit.row] as? PublicationViewModel
            }
        case "add item":
            print("item will be added")
        default:
            print("Segue does not exist")
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
    
    // MARK: - TableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexPathToEdit = indexPath
        guard let cell = heritageCollectionTableView.cellForRow(at: indexPath) as? HeritageObjectTableViewCell else {
            fatalError("Wrong TableViewCell")
        }
        switch(cell.objectCategoryLabel.text){
        case HeritageObjectCategory.artefact.rawValue:
            performSegue(withIdentifier: "show artefact", sender: HeritageCollectionTableViewController())
        case HeritageObjectCategory.monument.rawValue:
            performSegue(withIdentifier: "show monument", sender: HeritageCollectionTableViewController())
        case HeritageObjectCategory.metalDetectingFind.rawValue:
            performSegue(withIdentifier: "show find", sender: HeritageCollectionTableViewController())
        case HeritageObjectCategory.publication.rawValue:
            performSegue(withIdentifier: "show publication", sender: HeritageCollectionTableViewController())
        default:
            fatalError("Problemen!")
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: {(action, view, completionHandler) in
            self.indexPathToEdit = indexPath
            guard let cell = self.heritageCollectionTableView.cellForRow(at: self.indexPathToEdit) as? HeritageObjectTableViewCell else {
                fatalError("Wrong TableViewCell")
            }
            let object = self.getSegueIdentifier(with: HeritageObjectCategory(rawValue: cell.objectCategoryLabel.text!)!)
            self.performSegue(withIdentifier: "show \(object)", sender: self)
            completionHandler(true)
        })
        editAction.backgroundColor = UIColor.yellow
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: {(action, view, completionHandler) in
            let heritageObject = self.currentHeritageObjects[indexPath.row]
            DatabaseService.service.update(heritageObject, with: .delete)
            self.currentHeritageObjects.remove(at: indexPath.row)
            self.heritageObjects = self.currentHeritageObjects
            self.heritageCollectionTableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        })
        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
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
        let newIndexPath = IndexPath(row: heritageObjects.count, section: 0)
        heritageObjects.append(record)
        currentHeritageObjects = heritageObjects
        heritageCollectionTableView.insertRows(at: [newIndexPath], with: .automatic)
        for object in heritageObjects {
            print(object.name)
        }
    }
    
    private func getSegueIdentifier(with category: HeritageObjectCategory) -> String {
        switch(category){
        case .artefact:
            return "artefact"
        case .monument:
            return "monument"
        case .metalDetectingFind:
            return "find"
        case .publication:
            return "publication"
        }
    }

}
