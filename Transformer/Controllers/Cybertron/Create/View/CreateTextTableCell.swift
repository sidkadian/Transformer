//
//  CreateTextTableCell.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import UIKit

protocol CreateTextTableCellDelegate: AnyObject {
    func saveTransformerName(with name: String)
}

class CreateTextTableCell: UITableViewCell {

    // MARK: - UI Elements
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textfield: UITextField! {
        didSet {
            textfield.delegate = self
        }
    }

    // MARK: - Variables
    weak var delegate: CreateTextTableCellDelegate?

    // MARK: KVO
    var item: Item! {
        didSet {
            titleLabel.text = item.dataType.rawValue.capitalizingFirstLetter()
            textfield.text = item.value as? String
        }
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

// MARK: - UITextField Delegate
extension CreateTextTableCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.saveTransformerName(with: textField.text ?? "")
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.saveTransformerName(with: textField.text ?? "")
    }
}
