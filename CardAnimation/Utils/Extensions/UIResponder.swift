//_________SKAIK_MO_________
//
//  UIResponder.swift
//  CardAnimation
//
//  Created by Mohammed Skaik on 30/08/2024.
//

import Foundation
import UIKit

extension UIResponder {
    static var _id: String {
        return String(describing: self)
    }
    
    var _rootViewController: UIViewController? {
        return SceneDelegate.shared?.window?.rootViewController
    }

    var _topVC: UIViewController? {
        return _rootViewController?._topMostViewController
    }
    
}
