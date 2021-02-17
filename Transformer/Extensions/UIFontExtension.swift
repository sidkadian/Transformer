//
//  UIFontExtension.swift
//  Transformer
//
//  Created by Siddharth kadian on 16/02/21.
//

import UIKit

// MARK: - Add app fonts to be used by the app.
public extension UIFont {
    static let regular = "Avenir-Regular"
    static let medium = "Avenir-Medium"
    static let heavy = "Avenir-Heavy"
}

public extension UIFont {

    // Regular Style Fonts
    static var regular10: UIFont {
        return UIFont(name: medium, size: 10)!
    }

    static var regular12: UIFont {
        return UIFont(name: medium, size: 12)!
    }

    static var regular14: UIFont {
        return UIFont(name: medium, size: 14)!
    }
}

public extension UIFont {

    // Medium Style Fonts
    static var medium10: UIFont {
        return UIFont(name: medium, size: 10)!
    }

    static var medium12: UIFont {
        return UIFont(name: medium, size: 12)!
    }

    static var normal14: UIFont {
        return UIFont(name: medium, size: 14)!
    }

    static var medium16: UIFont {
        return UIFont(name: medium, size: 16)!
    }

    static var medium18: UIFont {
        return UIFont(name: medium, size: 18)!
    }

}

internal extension UIFont {

    // Heavy Style Fonts
    static var heavy20: UIFont {
        return UIFont(name: heavy, size: 20)!
    }

}
