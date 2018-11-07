//
//  Person+CoreDataProperties.swift
//  WorkingWithCoreData
//
//  Created by Justin Richardson on 2018-11-01.
//  Copyright © 2018 Justin Richardson. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}
