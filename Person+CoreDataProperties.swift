//
//  Person+CoreDataProperties.swift
//  FinalTodo
//
//  Created by Sarath P on 02/11/21.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Entity")
    }

    @NSManaged public var name: String?

}

extension Person : Identifiable {

}
