//
//  CategoryViewController.swift
//  Todoey
//
//  Created by vagelis spirou on 14/05/2019.
//  Copyright © 2019 vagelis spirou. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
        destinationVC.selectedCategory = categoryArray[indexPath.row]
            
        }
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new category"
            
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Add", style: .default) { [unowned self, alert] _ in
            
            let newCategory = Category(context: self.context)
            newCategory.name = alert.textFields![0].text!
            
            self.categoryArray.append(newCategory)
            
            self.saveCategories()
            
        })
        
        present(alert, animated: true)
        
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveCategories() {
        
        do {
            
            try context.save()
            
        } catch {
            
            print("Error saving context, \(error)")
            
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCategories() {
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            
            categoryArray = try context.fetch(request)
            
        } catch {
            
            print("Error fetching data from context, \(error)")
            
        }
        
        tableView.reloadData()
        
    }
    
}
