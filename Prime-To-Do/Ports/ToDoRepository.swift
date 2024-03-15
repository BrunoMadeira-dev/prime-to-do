//
//  ToDoRepository.swift
//  Prime-To-Do
//
//  Created by Bruno Madeira on 15/03/2024.
//

import Foundation
import CoreData

protocol TaskManager {
     
    func saveListItemData(item: String, done: Bool)
    func getAllItems() -> [ToDoListItem]
    func updateListItemData(sameItem: ToDoListItem, item: String, newDone: Bool)
    func deleteItem(sameItem: ToDoListItem)
}

class TaskManagerImplementation: TaskManager {
    
    let repository: TaskRepository?
    let context: NSManagedObjectContext
    
    init(repository: TaskRepository?, context: NSManagedObjectContext) {
        self.repository = repository
        self.context = context
    }
    
    func saveListItemData(item: String, done: Bool) {
        repository?.saveListItemData(item: item, done: done)
    }
    func getAllItems() -> [ToDoListItem] {
        if let itemArray = repository?.getAllItems() {
            return itemArray
        } else {
            return []
        }
    }
    
    func updateListItemData(sameItem: ToDoListItem, item: String, newDone: Bool) {
        repository?.updateListItemData(sameItem: sameItem, item: item, done: newDone)
    }
    
    func deleteItem(sameItem: ToDoListItem) {
        repository?.deleteItem(sameItem: sameItem)
    }
    
}
