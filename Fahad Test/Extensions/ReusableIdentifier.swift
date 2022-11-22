//
//  UITableView+Entension.swift
//  Fahad Test
//
//  Created by Mac on 15/11/2022.
//


import UIKit
import Foundation

protocol ReusableIdentifier {
    static var reuseIdentifier: String { get }
}

extension ReusableIdentifier {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}



/******** UITableViewCell&UICollectionViewCell<Extension> *******************************/
protocol CellConfigurer: AnyObject {
    static var nib: UINib { get }
    static var reusableIdentifier: String { get }
}

extension CellConfigurer {
    static var nib: UINib {
        return UINib(nibName: reusableIdentifier, bundle: nil)
    }
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: CellConfigurer {}
extension UITableViewCell: CellConfigurer {}

/*************************** UINIB<Extension> ************************************************/
extension UINib {
    class func nib(with name: String) -> UINib {
        return UINib(nibName: name, bundle: nil)
    }
}
