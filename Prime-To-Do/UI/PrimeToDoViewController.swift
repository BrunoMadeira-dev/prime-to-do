//
//  ViewController.swift
//  Prime-To-Do
//
//  Created by Bruno Madeira on 14/03/2024.
//

import UIKit
import CoreData

class PrimeToDoViewController: UITableViewController {

    var taskManager: StorageToDoAdapter?
    var tasks: [ToDoListItem] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var done: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Prime ToDo"
        let context = context
        let coreDataRepository = TaskManagerImplementation(context: context)
        let taskManager = StorageToDoAdapter(repository: coreDataRepository, context: context)
        self.taskManager = taskManager
        loadItems()
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
        cell.accessoryType = index.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = tasks[indexPath.row]
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Check", style: .default, handler: { _ in
            self.done = true
            item.done = !item.done
            if let text = item.name {
            self.changeTask(sameItem: item, item: text, done: item.done)
            }
            tableView.reloadData()
            
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.deleteItem(sameItem: item)
            tableView.reloadData()
        }))
        navigationController?.present(sheet, animated: true)
    }
    
    @IBAction func addNewItem(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new task", message: "", preferredStyle: .alert)
        
        let actionCreate = UIAlertAction(title: "Add", style: .default) { action in
            print("Success")
            
            if let text = textField.text {
                
                if text != "" {
                    self.addAction(item: text, done: false)
                } else {
                    //displays a Warning to tell that a item can't be empty
                    let alert = Utils().showPopup(title: "Warning", message: "Task can't be empty")
                    self.present(alert, animated: true)
                }
            }
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(actionCreate)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func addAction(item: String, done: Bool) {
        
        guard let task = taskManager else { return }
        task.saveListItemData(item: item, done: done)
        loadItems()
    }
    
    func changeTask(sameItem: ToDoListItem, item: String, done: Bool) {
        guard let task = taskManager else { return }
        task.updateListItemData(sameItem: sameItem, item: item, newDone: done)
    }
    
    func deleteItem(sameItem: ToDoListItem) {
        guard let task = taskManager else { return }
        task.deleteItem(sameItem: sameItem)
        loadItems()
    }
}

