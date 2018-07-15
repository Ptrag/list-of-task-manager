//
//  ViewController.swift
//  ListOfTask
//
//  Created by Pj on 15/07/2018.
//  Copyright © 2018 Pj. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["to do 1","to do 2", "to do 3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { 
        //print(itemArray[indexPath.row])
        
        
        if(tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true) //animated presses after releasing
        
        
    }
    
    @IBAction func addBtnPress(_ sender: UIBarButtonItem) {
        
        var textFiled = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //what will hapen when user clicks add btn
            self.itemArray.append(textFiled.text ?? "")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in            //alert popup customization
            alertTextField.placeholder = "Create new item"
            textFiled = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    

}

