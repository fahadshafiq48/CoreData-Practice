//
//  Router.swift
//  Fahad Test
//
//  Created by Mac on 15/11/2022.
//

import Foundation
import UIKit

@objc protocol RoutingLogic {}

protocol DataPassing {
    var dataStore: DataStore? { get }
}

class Router: NSObject, RoutingLogic, DataPassing {
    var dataStore: DataStore?
    weak var viewController: BaseViewController?
    
    override required init() {}    
}
