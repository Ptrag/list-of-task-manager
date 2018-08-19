//
//  CategoryViewController.swift
//  ListOfTask
//
//  Created by Pj on 12/08/2018.
//  Copyright © 2018 Pj. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }
    
    
    //TableView DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "no categories added yet"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier:  "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
    
    
    
    //Data Manipulation Metohds
    
    func save(category : Category) {
        
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Error savngn category \(error)")
        }
        
        tableView.reloadData()
        
        
    }
    
    func loadCategories(){
        
        categories = realm.objects(Category.self)

        
        tableView.reloadData()
        
    }
    
    //Add new Categories

   
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textFiled = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title:  "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textFiled.text!
            self.save(category: newCategory)
            
        }
        
        alert.addAction(action)
        alert.addTextField { (filed) in
            textFiled = filed
            textFiled.placeholder = "Add a new category"
        }
        
        present(alert,animated: true,completion: nil)
        
    }

}
