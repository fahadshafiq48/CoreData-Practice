//
//  ReminderDetailInteractor.swift
//  Fahad Test
//
//  Created by Mac on 21/11/2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

protocol ReminderDetailBusinessLogic {}

protocol ReminderDetailDataStore {}

class ReminderDetailInteractor: Interactor, ReminderDetailBusinessLogic, ReminderDetailDataStore {
    
    var presenterReminderDetail: ReminderDetailPresenter? {
        return presenter as? ReminderDetailPresenter
    }
    
    var worker: ReminderDetailWorker = ReminderDetailWorker()
    
    //var name: String = ""
    
}
