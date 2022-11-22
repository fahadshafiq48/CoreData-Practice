//
//  Interactor.swift
//  Fahad Test
//
//  Created by Mac on 15/11/2022.
//

import Foundation

protocol BusinessLogic {}

protocol DataStore {}

class Interactor: NSObject, BusinessLogic, DataStore {
    
    var presenter: PresentationLogic?
    
    required override init() {}
}
