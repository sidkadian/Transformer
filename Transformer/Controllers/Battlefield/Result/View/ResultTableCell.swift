//
//  ResultTableCell.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import UIKit

class ResultTableCell: UITableViewCell {

    // MARK: - UI Elements
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var transformerImageView: UIImageView!
    @IBOutlet weak var winnerReasonLabel: UILabel!

    // MARK: - Variables
    var transformer: BattlefieldModel! {
        didSet {
            winnerReasonLabel.text = transformer.winnerDetail.rawValue
            if transformer.winner == .autobot {
                nameLabel.text = transformer.autobot.name
                transformerImageView.image = .autobotLogo

            } else if transformer.winner == .decepticon {
                nameLabel.text = transformer.deception.name
                transformerImageView.image = .decepticonLogo
            } else {
                nameLabel.text = transformer.winnerDetail.rawValue
                transformerImageView.image = .deadIcon
            }
        }
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
