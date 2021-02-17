//
//  StringExtension.swift
//  Transformer
//
//  Created by Siddharth kadian on 16/02/21.
//

import Foundation

extension String {

    // MARK: - Capitalizing Only First Letter
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

}
