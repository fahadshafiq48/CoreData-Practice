//
//  BaseViewController.swift
//  Fahad Test
//
//  Created by Mac on 15/11/2022.
//

import UIKit

protocol DisplayLogic: AnyObject { }

class BaseViewController: UIViewController, DisplayLogic {
    
    var interactor: Interactor?
    var router: (NSObjectProtocol & RoutingLogic & DataPassing)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let selfName = String(describing: self)
        let completeBundle: String = String(selfName.dropFirst())
        let controllerPlusBundleString: String = completeBundle.components(separatedBy: ":").first!
        let bundleAndController = controllerPlusBundleString.components(separatedBy: ".")
        let bundleName = bundleAndController.first!
        let controllerName = bundleAndController.last!
        let nameIndex = controllerName.index(controllerName.endIndex, offsetBy: -14)
        let className = controllerName.prefix(upTo: nameIndex)
        
        let interactorName = "\(bundleName).\(className)Interactor"
        var interactor: Interactor?
        if let interactorClass = NSClassFromString(interactorName) as? Interactor.Type {
            interactor = interactorClass.init()
        }
        
        let presenterName = "\(bundleName).\(className)Presenter"
        var presenter: Presenter?
        if let presenterClass = NSClassFromString(presenterName) as? Presenter.Type {
            presenter = presenterClass.init()
        }
        
        let routerName = "\(bundleName).\(className)Router"
        var router: Router?
        if let routerClass = NSClassFromString(routerName) as? Router.Type {
            router = routerClass.init()
        }
        
        let viewController = self
        viewController.interactor = interactor
        viewController.router = router
        interactor?.presenter = presenter
        
        presenter?.viewController = viewController
        router?.viewController = viewController
        router?.dataStore = interactor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}
