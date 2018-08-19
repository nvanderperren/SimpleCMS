//
//  ListWithSectionsTableViewController.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 19/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

class ListWithSectionsTableViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var searchItemLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    

    var dataWithSections: [String: [String]]?
    var action: String?
    
    var sections: Int {
        if let data = dataWithSections {
            return data.keys.count
        } else {
            return 1
        }
    }
    
    var value: String? {
        didSet {
            if let value = value {
                saveButton.isEnabled = true
                searchItemLabel.text = "Gekozen term: " + value
            }
        }
    }
    var currentData = [String]()
    
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
    
    private func sortItems(with data: [String:[String]]) -> [String:[String]] {
        var sortedDictionary = data
        for (key,values) in data {
            let sortedValues = values.sorted{$0 < $1}
            sortedDictionary.updateValue(sortedValues, forKey: key)
        }
        return sortedDictionary
        
    }
    
    
    
    
    
}

extension ListWithSectionsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listSectionElementCell", for: indexPath)
            let section = indexPath.section
        let keys = Array(dataWithSections!.keys)
        let values = dataWithSections![keys[section]]
            if let values = values {
                cell.textLabel?.text = values[indexPath.row]
            }
        
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keys = Array(dataWithSections!.keys)
        return dataWithSections![keys[section]]!.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let data = dataWithSections {
            let keys = Array(data.keys)
            
            return keys[section]
        } else {
            return nil
        }
    }
}

extension ListWithSectionsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = dataWithSections {
            let section = indexPath.section
            let keys = Array(data.keys)
            let values = data[keys[section]]
            if let values = values {
                value = values[indexPath.row]
            }
        }
        
    }
}

