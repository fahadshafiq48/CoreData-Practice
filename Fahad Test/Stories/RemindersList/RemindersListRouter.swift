//
//  RemindersListRouter.swift
//  Fahad Test
//
//  Created by Mac on 21/11/2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol RemindersListRoutingLogic {
    func routeToReminderDetail(item: ListModel)
}

protocol RemindersListDataPassing {}

class RemindersListRouter: Router, RemindersListRoutingLogic, RemindersListDataPassing {
    
    weak var viewControllerRemindersList: RemindersListViewController? {
        return viewController as? RemindersListViewController
    }
    
    var dataStoreRemindersList: RemindersListDataStore? {
        return dataStore as? RemindersListDataStore
    }
    
    func routeToReminderDetail(item: ListModel) {
        let vc = ReminderDetailViewController.load(from: .main)
        vc.reminderDetail = item
        viewControllerRemindersList?.navigationController?.pushViewController(vc, animated: true)
    }
}
