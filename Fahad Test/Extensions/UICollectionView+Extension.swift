//
//  UITableView+Entension.swift
//  Fahad Test
//
//  Created by Mac on 15/11/2022.
//

import Foundation
import UIKit

extension UICollectionView {
    func configureCollectionView(size: CGSize, sectionInset: UIEdgeInsets) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = sectionInset
        layout.itemSize = CGSize(width: size.width/2, height: size.height)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 0
        self.collectionViewLayout = layout
    }
    
    /// Override dequeueReusableCell with T type means that could be any type of cell
    /// - Parameters:
    ///   - indexPath: array of the index for each cell
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue cell")
        }
        return cell
    }
    
    func registerNib(_ idetifier: String) {
        self.register(UINib(nibName: idetifier, bundle: Bundle.main), forCellWithReuseIdentifier: idetifier)
    }
    
//    func setupEmptyView(delegate: EmptyViewDelegate?) {
//        let emptyView = EmptyView.setupView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
//        self.backgroundView = emptyView
//        emptyView.delegate = delegate
//        self.backgroundView?.isHidden = true
//    }
//
//    func showEmptyView(viewType: EmptyViewType) {
//        guard let emptyView = backgroundView as? EmptyView else { return }
//        emptyView.viewType  = viewType
//        emptyView.viewSetup()
//        self.bringSubviewToFront(emptyView)
//        emptyView.isHidden  = false
//    }
//
//    func hideEmptyView() {
//        backgroundView?.isHidden = true
//    }
//
//    func hideRetryButton() {
//        guard let emptyView = backgroundView as? EmptyView else { return }
//        emptyView.retryButton.isHidden = true
//    }
}


