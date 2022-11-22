//
//  ReachibilityManager.swift
//  Fahad Test
//
//  Created by Mac on 15/11/2022.
//

import Foundation
import Alamofire

class ReachibilityManager {
    static let shared = ReachibilityManager()
    private var isNetworkAvailable = true
    private init() {}
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    
    func startNetworkReachabilityObserver() {
        reachabilityManager?.startListening { status in
            switch status {
            case .notReachable:
                self.isNetworkAvailable = false
                SnackBar.shared.showSnackBar("You are not connected to the internet", color: UIColor.red)
            case .unknown:
                self.isNetworkAvailable = false
                SnackBar.shared.showSnackBar("You are not connected to the internet", color: UIColor.red)
            case .reachable(.ethernetOrWiFi):
                self.isNetworkAvailable = true
                self.showInternetConnectionMessage()
            case .reachable(.cellular):
                self.isNetworkAvailable = true
                self.showInternetConnectionMessage()
            }
        }
    }
    
    private func showInternetConnectionMessage () {
        SnackBar.shared.hideSnackbar()
    }
    
    func isConnecteWithInternet() -> Bool {
        if !isNetworkAvailable {
            SnackBar.shared.showSnackBar("You are not connected to the internet", color: UIColor.red)
        }
        return isNetworkAvailable
    }
    
    func showSnackBar(withMessage: String = "You are not connected to the internet", color: UIColor = .red) {
        SnackBar.shared.showSnackBar(withMessage, color: color)
    }
    
    func checkInternetConnectionWithOutShowingError() -> Bool {
        return isNetworkAvailable
    }
}
