//
//  BundleExtension.swift
//  Transformer
//
//  Created by Siddharth kadian on 16/02/21.
//

import Foundation

public extension Bundle {

    /// getting data from info plist
    /// Bundle.main.getString(for: "APIBaseURL", fromPlist: "Info")!
    func getString(for key: String, fromPlist plist: String) -> String? {
        if let path = path(forResource: plist, ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            if let dict = dictRoot {
                return dict[key] as? String
            }
        }
        return .none
    }

}
