//
//  ReminderItem+CoreDataProperties.swift
//  
//
//  Created by Mac on 22/11/2022.
//
//

import Foundation
import CoreData


extension ReminderItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReminderItem> {
        return NSFetchRequest<ReminderItem>(entityName: "ReminderItem")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var schedule: [String:String]?

}
