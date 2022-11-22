//
//  Storyboard+Entension.swift
//  Fahad Test
//
//  Created by Mac on 15/11/2022.
//


import Foundation
import UIKit

enum Storyboard: String {
    case main              = "Main"
}

protocol Storyboardable: AnyObject { }

extension Storyboardable where Self: UIViewController {
    static func load(from storyboard: Storyboard) -> Self {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: Self.reuseIdentifier) as? Self else {
            fatalError("Could not instantiate storyboard")
        }
        return viewController
    }
    
    static func loadNavigation(from storyboard: Storyboard) -> UINavigationController {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        guard let navigationController = storyboard.instantiateViewController(withIdentifier: Self.reuseIdentifier) as? UINavigationController else {
            fatalError("Could not instantiate storyboard")
        }
        return navigationController
    }
}

extension UICollectionViewCell {}
extension UIViewController: Storyboardable { }
extension UIViewController: ReusableIdentifier {}
extension UIView: ReusableIdentifier {}
