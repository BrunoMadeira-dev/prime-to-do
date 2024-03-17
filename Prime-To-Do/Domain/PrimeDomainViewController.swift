//
//  PrimeDomainViewController.swift
//  Prime-To-Do
//
//  Created by Bruno Madeira on 16/03/2024.
//

import Foundation
import UIKit


class PrimeDomainViewController {
    
    var taskManager: StorageToDoAdapter?
    var tasks: [ToDoListItem] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var done: Bool = false
    
    func addAction(item: String, done: Bool) {
        let context = context
        let coreDataRepository = TaskManagerImplementation(context: context)
        let taskManager = StorageToDoAdapter(repository: coreDataRepository, context: context)
        self.taskManager = taskManager
        taskManager.saveListItemData(item: item, done: done)
        //loadItems()
    }
    
//    func loadItems() -> [ToDoListItem] {
//        
//       tasks = taskManager?.getAllItems() ?? []
//        return tasks
//    }
    
}
