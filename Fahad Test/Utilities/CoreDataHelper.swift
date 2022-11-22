//
//  CoreDataHelper.swift
//  Fahad Test
//
//  Created by Mac on 22/11/2022.
//

import Foundation
import UIKit
import CoreData

class CoreDataHelper {
    
    static var shared = CoreDataHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func saveReminder(item: ListModel){
        let list = NSEntityDescription.insertNewObject(forEntityName: "ReminderItem", into: context!) as! ReminderItem
        list.name = item.name
        list.id = item.id
        list.imageURL = item.imageURL
        list.schedule = item.schedule?.dayTime as NSObject?
        
        do{
            try context?.save()
        }catch{
            print("data doesn't save - CoreDataHelper")
        }
    }
    
    func getRemindersData()->[ReminderItem]{
        var list = [ReminderItem]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ReminderItem")
        do{
            list = try context?.fetch(fetchRequest) as! [ReminderItem]
        }catch{
            print("Data can't be fetched - CoreDataHelper")
        }
        return list
    }
    
    func deleteReminders() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ReminderItem")
        
        do{
            let results = try context?.fetch(fetchRequest) as! [ReminderItem]
            for managedObject in results
            {
                let managedObjectData: NSManagedObject = managedObject as NSManagedObject
                context?.delete(managedObjectData)
            }
            try context?.save()
            
        }catch{
            print("Data can't be Deleted - CoreDataHelper")
        }
    }
}
