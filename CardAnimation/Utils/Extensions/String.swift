//_________SKAIK_MO_________
//
//  String.swift
//  CardAnimation
//
//  Created by Mohammed Skaik on 30/08/2024.
//

import Foundation
import UIKit

extension String {

    var _hexColor: UIColor {
        return UIColor.init(named: self) ?? UIColor.init(hexString: self)
    }

    var _color: UIColor {
        return UIColor.init(named: self) ?? UIColor.init(hexString: self)
    }

    var _toImage: UIImage? {
        return UIImage.init(named: self)
    }

    var _removeWhiteSpace: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

}
