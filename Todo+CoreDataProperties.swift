//
//  Todo+CoreDataProperties.swift
//  FinalTodo
//
//  Created by Sarath P on 05/11/21.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var todoList: String?
    @NSManaged public var state: Bool

}

extension Todo : Identifiable {

}
