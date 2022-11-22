//
//  UITableView+Entension.swift
//  Fahad Test
//
//  Created by Mac on 15/11/2022.
//

import Foundation
import UIKit

extension UITableView {
    
    /// Override dequeueReusableCell with T type means that could be any type of cell
    /// - Parameters:
    ///   - indexPath: array of the index for each cell
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue cell")
        }
        return cell
    }
    
    func registerNib(_ identifier: String) {
        self.register(UINib(nibName: identifier, bundle: Bundle.main), forCellReuseIdentifier: identifier)
    }
}
