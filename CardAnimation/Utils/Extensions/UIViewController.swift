//_________SKAIK_MO_________
//
//  UIViewController.swift
//  CardAnimation
//
//  Created by Mohammed Skaik on 30/08/2024.
//

import Foundation
import UIKit

// MARK: - Transfers Shortcuts
extension UIViewController {
    
    var _topMostViewController: UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?._topMostViewController
        } else if let tabBarController = self as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                return selectedViewController._topMostViewController
            }
            return tabBarController._topMostViewController
        } else if let presentedViewController = self.presentedViewController {
            return presentedViewController._topMostViewController
        } else {
            return self
        }
    }
}

extension UIViewController {

    var _getStatusBarHeightTop: CGFloat? {
        return SceneDelegate.shared?.window?.safeAreaInsets.top
    }

    var _isHideNavigation: Bool {
        get {
            return self.navigationController?.isNavigationBarHidden ?? false
        }
        set {
            self.navigationController?.setNavigationBarHidden(newValue, animated: true)
        }
    }

}
