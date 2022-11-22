//
//  Presenter.swift
//  Fahad Test
//
//  Created by Mac on 15/11/2022.
//

import Foundation

protocol PresentationLogic {}

class Presenter: NSObject, PresentationLogic {
    weak var viewController: DisplayLogic?
    
    override required init() {}
}
