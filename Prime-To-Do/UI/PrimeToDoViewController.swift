//
//  ViewController.swift
//  Prime-To-Do
//
//  Created by Bruno Madeira on 14/03/2024.
//

import UIKit
import CoreData

class PrimeToDoViewController: UITableViewController {

    var taskManager: TaskManagerImplementation?
    var tasks: [ToDoListItem] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let context = context
        let coreDataRepository = StorageToDoAdapter(context: context)
        let taskManager = TaskManagerImplementation(repository: coreDataRepository, context: context)
        self.taskManager = taskManager
        loadItems()
        //tableView.reloadData()
    }
    
    func loadItems() {
        guard let task = taskManager else { return }
        tasks = task.getAllItems()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrimeCell", for: indexPath)
        
        cell.textLabel?.text = index.name
        return cell
    }
    
    @IBAction func addNewItem(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Item", style: .default) { action in
            print("Success")
            
            if let text = textField.text {
                self.addAction(item: text, done: false)
            }
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func addAction(item: String, done: Bool) {
        
        guard let task = taskManager else { return }
        
        task.saveListItemData(item: item, done: done)
        loadItems()
    }
}

