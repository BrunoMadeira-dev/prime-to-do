//
//  StorageToDoAdapter.swift
//  Prime-To-Do
//
//  Created by Bruno Madeira on 14/03/2024.
//

import Foundation
import CoreData
import UIKit

class StorageToDoAdapter: TaskRepository {
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func updateListItemData(sameItem: ToDoListItem, item: String, done: Bool) {
        let newItem = sameItem
        newItem.name = item
        newItem.done = done
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    
    //let context2 = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemArray = [ToDoListItem]()
    
    func getAllItems() -> [ToDoListItem] {
        do {
            itemArray = try context.fetch(ToDoListItem.fetchRequest())
            return itemArray
        } catch {
            print(error)
            return []
        }
    }
    
    func saveListItemData(item: String, done: Bool) {
        let newItem = ToDoListItem(context: context)
        newItem.name = item
        newItem.done = done
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func deleteItem(sameItem: ToDoListItem) {
        context.delete(sameItem)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
