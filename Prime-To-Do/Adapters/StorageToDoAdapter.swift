//
//  StorageToDoAdapter.swift
//  Prime-To-Do
//
//  Created by Bruno Madeira on 14/03/2024.
//

import Foundation
import CoreData
import UIKit

protocol TaskManager {
     
    func saveListItemData(item: String, done: Bool)
    func getAllItems() -> [ToDoListItem]
    func updateListItemData(sameItem: ToDoListItem, item: String, newDone: Bool)
    func deleteItem(sameItem: ToDoListItem)
}

class StorageToDoAdapter: TaskManager {
    
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
