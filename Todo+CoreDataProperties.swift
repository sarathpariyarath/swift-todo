//
//  Todo+CoreDataProperties.swift
//  FinalTodo
//
//  Created by Sarath P on 03/11/21.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var todoList: String?

}

extension Todo : Identifiable {

}
