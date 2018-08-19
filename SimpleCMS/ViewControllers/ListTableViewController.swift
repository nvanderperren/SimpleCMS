//
//  ListTableViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 18/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class ListTableViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchItemLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var isSearching: Bool = false
    
    
    var data: [String]?
    var action: String?
    
    var value: String? {
        didSet {
            if let value = value {
                saveButton.isEnabled = true
                searchItemLabel.text = "Gekozen term: " + value
                
            }
        }
    }
    var filteredData = [String]()
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didChoose(_ sender: UIBarButtonItem) {
        if let action = action {
            performSegue(withIdentifier: action, sender: ListTableViewController())
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        searchItemLabel.text = "Kies term"
        

        // Do any additional setup after loading the view.
    }
    
    

 

}

extension ListTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredData.count
        } else {
            return data!.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listElementCell", for: indexPath)
        if isSearching {
            cell.textLabel?.text = filteredData[indexPath.row]
        } else {
            cell.textLabel?.text = data?[indexPath.row]
        }
        return cell
    }
}

extension ListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching {
            value = filteredData[indexPath.row]
            print(value ?? "geen term")
        }
        else {
            value = data?[indexPath.row]
            print(value ?? "geen term")
        }
        
        
    }
}

extension ListTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        filteredData = data!.filter{ element -> Bool in
                return element.lowercased().contains(searchText.lowercased())
            }
        isSearching = true
        listTableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        listTableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        filteredData = data!
        listTableView.reloadData()
        searchBar.showsCancelButton = true
    }
    
}



