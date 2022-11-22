//
//  RemindersListLocalDBWorker.swift
//  Fahad Test
//
//  Created by Mac on 22/11/2022.
//

import Foundation
class RemindersListLocalDBWorker {
    func doFetchLocalList() -> [ListModel] {
        var dataSource = [ListModel]()
        for i in CoreDataHelper.shared.getRemindersData() {
            let item = ListModel()
            item.name = i.name
            item.id = i.id
            item.imageURL = i.imageURL
            item.schedule?.dayTime = i.schedule as! [String : String]
            dataSource.append(item)
        }
        
        return dataSource
    }
    
    func doSaveLocalList(items: [ListModel]) {
        if !items.isEmpty {
            CoreDataHelper.shared.deleteReminders()
            for i in items {
                CoreDataHelper.shared.saveReminder(item: i)
            }
        }
    }
}
