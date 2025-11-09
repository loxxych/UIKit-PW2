//
//  Wish+CoreDataProperties.swift
//  aibednovaPW2
//
//  Created by loxxy on 09.11.2025.
//
//

import Foundation
import CoreData


extension Wish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wish> {
        return NSFetchRequest<Wish>(entityName: "Wish")
    }

    @NSManaged public var wishText: String?

}

extension Wish : Identifiable {

}
