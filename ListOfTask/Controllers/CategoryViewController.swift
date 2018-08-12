//
//  CategoryViewController.swift
//  ListOfTask
//
//  Created by Pj on 12/08/2018.
//  Copyright © 2018 Pj. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }
    
    
    //TableView DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier:  "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
        
    }
    
    
    
    //Data Manipulation Metohds
    
    func saveCategories() {
        
        do{
            try context.save()
        }catch{
            print("Error savngn category \(error)")
        }
        
        tableView.reloadData()
        
        
    }
    
    func loadCategories(){
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(request)
        } catch {
            print("error loading categories \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    //Add new Categories

   
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textFiled = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title:  "Add", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textFiled.text!
            self.categories.append(newCategory)
            self.saveCategories()
            
        }
        
        alert.addAction(action)
        alert.addTextField { (filed) in
            textFiled = filed
            textFiled.placeholder = "Add a new category"
        }
        
        present(alert,animated: true,completion: nil)
        
    }

}
