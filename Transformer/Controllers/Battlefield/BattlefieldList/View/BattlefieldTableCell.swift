//
//  BattlefieldTableCell.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import UIKit

class BattlefieldTableCell: UITableViewCell {

    // MARK: - UI Elements
    @IBOutlet weak var autobotsNameLabel: UILabel!
    @IBOutlet weak var autobotsImageView: UIImageView!
    @IBOutlet weak var decepticonNameLabel: UILabel!
    @IBOutlet weak var decepticonImageView: UIImageView!
    @IBOutlet weak var winnerLabel: UILabel!

    // MARK: - KVO
    var transformer: BattlefieldModel! {
        didSet {
            autobotsNameLabel.text = transformer.autobot.name?.capitalizingFirstLetter()
            decepticonNameLabel.text = transformer.deception.name?.capitalizingFirstLetter()

            if transformer.winner == .autobot {
                autobotsImageView.image = .autobotLogo
                decepticonImageView.image = .deadIcon
                winnerLabel.text = AppStrings.Result.autobotsWins

            } else if transformer.winner == .decepticon {
                autobotsImageView.image = .deadIcon
                decepticonImageView.image = .decepticonLogo
                winnerLabel.text = AppStrings.Result.decepticonsWin

            } else {
                autobotsImageView.image = .deadIcon
                decepticonImageView.image = .deadIcon
                winnerLabel.text = AppStrings.Result.draw

            }
        }
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
