//
//  CreateSelectTableCell.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import UIKit

class CreateSelectTableCell: UITableViewCell {

    // MARK: - UI Elements
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    // MARK: KVO
    var item: Item! {
        didSet {
            titleLabel.text = item.dataType.rawValue.capitalizingFirstLetter()

            if let valueStr = item.value as? String,
               valueStr != "" {
                descriptionLabel.text = valueStr
            } else if let valueStr = item.value as? Int {
                descriptionLabel.text = "\(valueStr)"
            } else {
                descriptionLabel.text = AppStrings.Create.select
            }
        }
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
