//
//  BattlefieldModel.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import Foundation

enum BattlefielResultEnum {
    case autobot
    case decepticon
    case destroyed
    case none
}

enum BattlefielWinners: String {
    case optimus = "Optimus Wins"
    case predaking = "Predaking Wins"
    case strong = "Won By Stronger Rule"
    case skill = "Won By Skill Points Rule"
    case overallRating = "Won By Overall Rating Rule"
    case none = "None"
}

struct BattlefieldModel {
    let winner: BattlefielResultEnum
    let winnerDetail: BattlefielWinners
    let autobot: Transformer
    let deception: Transformer
}
