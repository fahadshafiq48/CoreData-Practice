//
//  SnackBar.swift
//  Fahad Test
//
//  Created by Mac on 15/11/2022.
//

import Foundation
import SwiftMessages

class SnackBar: UIViewController {
    static let shared = SnackBar()
    
    func showSnackBar(_ message: String, color bgColor: UIColor) {
        
        let view = MessageView.viewFromNib(layout: .statusLine)

        // Theme message elements with the warning style.
        view.configureTheme(.error)

        // Add a drop shadow.
        view.configureDropShadow()

        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
    
        view.configureContent(title: "Warning", body: message)
        view.button?.isHidden = true
//        view.button = nil

        // Increase the external margin around the card. In general, the effect of this setting
        // depends on how the given layout is constrained to the layout margins.
//        view.layoutMarginAdditions = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        // Reduce the corner radius (applicable to layouts featuring rounded corners).
//        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 0

        // Show the message.
//        var config = SwiftMessages.defaultConfig
        
        var config = SwiftMessages.Config()

        // Slide up from the bottom.
        config.presentationStyle = .top

        // Display in a window at the specified window level: UIWindow.Level.statusBar
        // displays over the status bar while UIWindow.Level.normal displays under.
        config.presentationContext = .window(windowLevel: .normal)

        // Disable the default auto-hiding behavior.
        config.duration = .seconds(seconds: 3)

        // Dim the background like a popover view. Hide when the background is tapped.
//        config.dimMode = .gray(interactive: true)

        // Disable the interactive pan-to-hide gesture.
//        config.interactiveHide = false

        // Specify a status bar style to if the message is displayed directly under the status bar.
        config.preferredStatusBarStyle = .default
        SwiftMessages.show(config: config, view: view)
//        config.presentationStyle = .top
    }
    
    func showSuccessSnackBar(_ message: String, type: Theme = .success) {
        
        let view = MessageView.viewFromNib(layout: .statusLine)

        // Theme message elements with the warning style.
        view.configureTheme(type)

        // Add a drop shadow.
        view.configureDropShadow()

        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
    
        view.configureContent(title: "Success", body: message)
        view.button?.isHidden = true
//        view.button = nil

        // Increase the external margin around the card. In general, the effect of this setting
        // depends on how the given layout is constrained to the layout margins.
//        view.layoutMarginAdditions = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        // Reduce the corner radius (applicable to layouts featuring rounded corners).
//        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 0

        // Show the message.
//        var config = SwiftMessages.defaultConfig
        
        var config = SwiftMessages.Config()

        // Slide up from the bottom.
        config.presentationStyle = .top

        // Display in a window at the specified window level: UIWindow.Level.statusBar
        // displays over the status bar while UIWindow.Level.normal displays under.
        config.presentationContext = .window(windowLevel: .normal)

        // Disable the default auto-hiding behavior.
        config.duration = .seconds(seconds: 3)

        // Dim the background like a popover view. Hide when the background is tapped.
//        config.dimMode = .gray(interactive: true)

        // Disable the interactive pan-to-hide gesture.
//        config.interactiveHide = false

        // Specify a status bar style to if the message is displayed directly under the status bar.
        config.preferredStatusBarStyle = .default
        SwiftMessages.show(config: config, view: view)
//        config.presentationStyle = .top
    }
    
    func hideSnackbar() {
        SwiftMessages.hideAll()
//        snackbar?.dismiss()
    }
}
