//_________SKAIK_MO_________
//
//  UIKitHelpers.swift
//  CardAnimation
//
//  Created by Mohammed Skaik on 30/08/2024.
//

import Foundation
import UIKit

// swiftlint:disable type_name
class rView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
}

class rStack: UIStackView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
}

class rButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
}
