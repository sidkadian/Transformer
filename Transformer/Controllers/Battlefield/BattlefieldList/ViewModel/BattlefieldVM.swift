//
//  BattlefieldVM.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import Foundation
import ProgressHUD

protocol BattlefieldVMDelegate: class {
    func userListApiDidFinish(success: Bool, message: String?)
}

class BattlefieldVM {

    // MARK: - Variables
    var networkManager: NetworkManagerProtocol = NetworkManager()
    var autobot = [Transformer]()
    var decepticon = [Transformer]()
    var result = ""
    var survivors = [Transformer]()
    var battleModel = [BattlefieldModel]()
    weak var delegate: BattlefieldVMDelegate?

    // MARK: Initilisation
    init(delegate: BattlefieldVMDelegate) {
        self.delegate = delegate
        fetchTransformers()
    }

    // MARK: - API call
    func fetchTransformers() {
        ProgressHUD.show()
        networkManager.getDataFromServiceApi(type: TransformerModel.self,
                                      call: .getData, postData: nil) { [weak self] (jsonData, error)  in
            DispatchQueue.main.async {

                ProgressHUD.dismiss()
                self?.autobot.removeAll()
                self?.decepticon.removeAll()
                guard error == nil else {
                    self?.delegate?.userListApiDidFinish(success: false, message: AppStrings.Alert.somethingWentWrong)
                    return
                }
                guard let jsonData = jsonData, jsonData.transformers.count > 0 else {
                    self?.delegate?.userListApiDidFinish(success: false, message: AppStrings.Alert.noTransformerFight)
                    return
                }
                self?.autobot = jsonData.transformers.filter { $0.team == Team.autobots.rawValue }
                self?.decepticon = jsonData.transformers.filter { $0.team == Team.decepticons.rawValue }

                self?.prepareBattleData()
            }
        }
    }

    // MARK: - Battle Data
    func prepareBattleData() {
        self.autobot = self.sort(transformers: autobot)
        self.decepticon = self.sort(transformers: decepticon)

        if autobot.count != 0 && decepticon.count == 0 {
            survivors = autobot

        } else if autobot.count == 0 && decepticon.count != 0 {
            survivors = decepticon

        } else if autobot.count == decepticon.count {
            _ = autobot.enumerated().map {  (index, _) in
                self.validateBattleRules(autobot: autobot[index], decepticon: decepticon[index])
            }

        } else if autobot.count > decepticon.count {
            _ = autobot.enumerated().map {  (index, transformer) in
                if index < decepticon.count {
                    self.validateBattleRules(autobot: autobot[index], decepticon: decepticon[index])
                } else {
                    survivors.append(transformer)
                }
            }

        } else if autobot.count < decepticon.count {
            _ = decepticon.enumerated().map {  (index, transformer) in
                if index < autobot.count {
                    self.validateBattleRules(autobot: autobot[index], decepticon: decepticon[index])
                } else {
                    survivors.append(transformer)
                }
            }
        }
        self.delegate?.userListApiDidFinish(success: true, message: "")
    }

    // MARK: - Battle Rules
    func sort(transformers: [Transformer]) -> [Transformer] {
        /*
         Battle Rule:
         The teams should be sorted by rank and faced off one on one against
         each other in order to determine a victor, the loser is eliminated
         */
        return transformers.sorted(by: { (transformer1, transformer2) -> Bool in
            return transformer1.rank ?? 0 < transformer2.rank ?? 0
        })
    }

    func validateBattleRules(autobot: Transformer, decepticon: Transformer) {
        /*
         Rule 1:
         Any Transformer named Optimus Prime or Predaking wins his fight automatically
         regardless of any other criteria
         In the event either of the above face each other (or a duplicate of each other),
         the game immediately ends with all competitors destroyed
         */
        if (decepticon.name == AppConstants.Rules.transformer1 &&
                autobot.name == AppConstants.Rules.transformer2) ||
                (decepticon.name == AppConstants.Rules.transformer2 &&
                    autobot.name == AppConstants.Rules.transformer1) ||
                (decepticon.name == AppConstants.Rules.transformer1 &&
                    autobot.name == AppConstants.Rules.transformer1) ||
                (decepticon.name == AppConstants.Rules.transformer2 &&
                    autobot.name == AppConstants.Rules.transformer2) {
            let model = BattlefieldModel(winner: .destroyed, winnerDetail: .none,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        } else if autobot.name == AppConstants.Rules.transformer2 {
            let model = BattlefieldModel(winner: .autobot, winnerDetail: .optimus,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        } else if decepticon.name == AppConstants.Rules.transformer1 {
            let model = BattlefieldModel(winner: .decepticon, winnerDetail: .predaking,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        }

        validateSecondRule(autobot: autobot, decepticon: decepticon)
    }

    func validateSecondRule(autobot: Transformer, decepticon: Transformer) {
        /*
         RULE 2:
         If any fighter is down 4 or more points of courage and 3 or more points of strength
         compared to their opponent, the opponent automatically wins the face-off regardless of
         overall rating (opponent has ran away)
         */
        if (((autobot.strength ?? 0) - (decepticon.strength ?? 0)) >= AppConstants.Rules.rule2StrengthPoints) &&
            (((decepticon.courage ?? 0) - (autobot.courage ?? 0)) >= AppConstants.Rules.rule2CouragePoints) {
            let model = BattlefieldModel(winner: .decepticon, winnerDetail: .strong,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        } else if (((decepticon.strength ?? 0) - (autobot.strength ?? 0)) >= AppConstants.Rules.rule2StrengthPoints) &&
                    (((autobot.courage ?? 0) - (decepticon.courage ?? 0)) >= AppConstants.Rules.rule2CouragePoints) {
            let model = BattlefieldModel(winner: .autobot, winnerDetail: .strong,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        }

        validateThirdRule(autobot: autobot, decepticon: decepticon)
    }

    func validateThirdRule(autobot: Transformer, decepticon: Transformer) {
        /*
         RULE 3:
         if one of the fighters is 3 or more points of skill above their opponent, they
         win the fight regardless of overall rating
         */
        if ((autobot.skill ?? 0) - (decepticon.skill ?? 0)) >= AppConstants.Rules.rule3minPoints {
            let model = BattlefieldModel(winner: .autobot, winnerDetail: .skill,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        } else if ((decepticon.skill ?? 0) - (autobot.skill ?? 0)) >= AppConstants.Rules.rule3minPoints {
            let model = BattlefieldModel(winner: .decepticon, winnerDetail: .skill,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        }

        validateForthRule(autobot: autobot, decepticon: decepticon)
    }

    func validateForthRule(autobot: Transformer, decepticon: Transformer) {
        /*
         RULE 4:
         The winner is the Transformer with the highest overall rating and In the event of a tie,
         both Transformers are considered destroyed
         The “overall rating” of a Transformer is the following formula:
         (Strength + Intelligence + Speed + Endurance + Firepower).
         */
        var autobotOverallRating = 0
        var decepticonOverallRating = 0
        if let strength = autobot.strength,
           let intelligence = autobot.intelligence,
           let speed = autobot.speed,
           let endurance = autobot.endurance,
           let firepower = autobot.firepower {
             autobotOverallRating = strength + intelligence + speed + endurance + firepower
        }

        if let strength = decepticon.strength,
           let intelligence = decepticon.intelligence,
           let speed = decepticon.speed,
           let endurance = decepticon.endurance,
           let firepower = decepticon.firepower {
             decepticonOverallRating = strength + intelligence + speed + endurance + firepower
        }

        if autobotOverallRating > decepticonOverallRating {
            let model = BattlefieldModel(winner: .autobot, winnerDetail: .overallRating,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        } else if decepticonOverallRating > autobotOverallRating {
            let model = BattlefieldModel(winner: .decepticon, winnerDetail: .overallRating,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        } else {
            let model = BattlefieldModel(winner: .destroyed, winnerDetail: .none,
                                    autobot: autobot, deception: decepticon)
            battleModel.append(model)
            return
        }
    }

}
