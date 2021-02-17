//
//  NSObjectExtension.swift
//  Transformer
//
//  Created by Siddharth kadian on 16/02/21.
//

import Foundation

public extension NSObject {
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }

    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
