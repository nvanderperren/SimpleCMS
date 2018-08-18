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
    
    
    var data: [String] = []
    var value: String? {
        didSet {
            if value != nil {
                saveButton.isEnabled = true
                searchItemLabel.text = value
            }
        }
    }
    var currentData = [String]()
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation
    
    

 

}

extension ListTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listElementCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}

extension ListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        value = data[indexPath.row]
    }
}

extension ListTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        guard !searchText.isEmpty else {
            currentData = data
            listTableView.reloadData()
            return
        }
        currentData = data.filter{ element -> Bool in
            return element.lowercased().contains(searchText.lowercased())
        }
        listTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        currentData = data
        listTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentData = data
        listTableView.reloadData()
        searchBar.resignFirstResponder()
    }

}


