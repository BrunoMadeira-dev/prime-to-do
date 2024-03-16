//
//  TaskRepository.swift
//  Prime-To-Do
//
//  Created by Bruno Madeira on 15/03/2024.
//

import Foundation


protocol TaskRepository {
    func saveListItemData(item: String, done: Bool)
    func getAllItems() -> [ToDoListItem]
    func updateListItemData(sameItem: ToDoListItem, item: String, done: Bool)
    func deleteItem(sameItem: ToDoListItem)
}
