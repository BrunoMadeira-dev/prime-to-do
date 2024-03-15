//
//  ToDoListItem+CoreDataProperties.swift
//  Prime-To-Do
//
//  Created by Bruno Madeira on 15/03/2024.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var done: Bool
    @NSManaged public var name: String?

}

extension ToDoListItem : Identifiable {

}
