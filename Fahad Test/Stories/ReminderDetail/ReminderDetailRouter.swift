//
//  ReminderDetailRouter.swift
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

@objc protocol ReminderDetailRoutingLogic {}

protocol ReminderDetailDataPassing {}

class ReminderDetailRouter: Router, ReminderDetailRoutingLogic, ReminderDetailDataPassing {
    
    weak var viewControllerReminderDetail: ReminderDetailViewController? {
        return viewController as? ReminderDetailViewController
    }
    
    var dataStoreReminderDetail: ReminderDetailDataStore? {
        return dataStore as? ReminderDetailDataStore
    }
    
}
