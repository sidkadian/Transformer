//
//  UITableViewExtension.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import UIKit

public extension UITableView {

    func setEmptyView(with status: Bool, message: String = "No Data") {
        if !status {
            self.backgroundView = nil
            return
        }
        if self.backgroundView == nil {
            let messageLabel = UILabel()
            messageLabel.text = message
            messageLabel.numberOfLines = 0
            messageLabel.backgroundColor = .themeColor
            messageLabel.textAlignment = .center
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.textColor = .appWhiteColor
            messageLabel.font = .heavy20
            self.backgroundView = messageLabel
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
    }

    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }

}

public extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
