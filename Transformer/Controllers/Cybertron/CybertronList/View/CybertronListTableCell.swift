//
//  CybertronListTableCell.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import UIKit
import SDWebImage

class CybertronListTableCell: UITableViewCell {

    // MARK: - UI Elements
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var specsLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!

    // MARK: KVO
    var transformer: TransformerListItems! {
        didSet {
            iconImageView.sd_setImage(with: URL(string: transformer.teamIcon), placeholderImage: .placeholder)
            nameLabel?.text = transformer.name
            rankLabel?.text = "\(AppStrings.Cybertron.rank): \(transformer.rank)"
            ratingLabel?.text = "\(AppStrings.Cybertron.overallRating): \(transformer.overallRating)"

            let combinedString = String.init(format: "%@: %i, %@: %i, %@: %i, %@: %i, %@: %i, %@: %i, %@: %i",
                                             AppStrings.Cybertron.courage, transformer.courage,
                                             AppStrings.Cybertron.skill, transformer.skill,
                                             AppStrings.Cybertron.endurance, transformer.endurance,
                                             AppStrings.Cybertron.firepower, transformer.firepower,
                                             AppStrings.Cybertron.intelligence, transformer.intelligence,
                                             AppStrings.Cybertron.speed, transformer.speed,
                                             AppStrings.Cybertron.strength, transformer.strength)
            specsLabel.text = combinedString
        }
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
