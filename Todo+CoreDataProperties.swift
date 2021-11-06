//
//  Todo+CoreDataProperties.swift
//  FinalTodo
//
//  Created by Sarath P on 06/11/21.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var state: Bool
    @NSManaged public var todoList: String?
    @NSManaged public var time: Date?

}

extension Todo : Identifiable {

}
