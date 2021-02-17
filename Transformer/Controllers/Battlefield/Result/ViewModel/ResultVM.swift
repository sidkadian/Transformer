//
//  ResultVM.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import Foundation

enum TransformerResultEnum {
    case autobot
    case decepticon
    case none
}

class ResultVM {

    // MARK: - Variables
    var battleModel = [BattlefieldModel]()

    // MARK: - Closures
    var userResultListClosure: ((String, TransformerResultEnum) -> Void)?

    // MARK: Initilisation
    init(battleModel: [BattlefieldModel]) {
        self.battleModel = battleModel
    }

    // MARK: - Functions
    func calculateFinalResults() {
        /*
         Winner Team Rule:
         The team who eliminated the largest number of the opposing team is the winner
         */
        let autobotTeam = battleModel.filter { $0.winner == .autobot }
        let deceptionTeam = battleModel.filter { $0.winner == .decepticon }
        var message = AppStrings.Result.noResult
        var winner: TransformerResultEnum = .none
        if battleModel.count == 0 {
            message = AppStrings.Result.noResult
            winner = .none
        } else if autobotTeam.count == deceptionTeam.count {
            message = AppStrings.Result.matchTie
            winner = .none
        } else if autobotTeam.count > deceptionTeam.count {
            message = AppStrings.Result.autobotsWins
            winner = .autobot
        } else if autobotTeam.count < deceptionTeam.count {
            message = AppStrings.Result.decepticonsWin
            winner = .decepticon
        }
        self.userResultListClosure?(message, winner)
    }

}
