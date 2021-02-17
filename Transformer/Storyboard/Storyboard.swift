//
//  Storyboard.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import Foundation

struct Storyborad {

    enum StoryboardType {
        case main
    }

    static func storyboardUsed(for type: StoryboardType) -> String {

        let storyboardString: String
        switch type {
        case .main:
            storyboardString = "Main"
        }
        return storyboardString
    }

}
