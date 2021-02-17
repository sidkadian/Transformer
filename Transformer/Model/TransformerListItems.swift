//
//  TransformerListItems.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import Foundation

enum Team: String {
    case autobots = "A"
    case decepticons = "D"
}

struct TransformerListItems {

    let endurance, firepower, intelligence, speed, strength, overallRating: Int
    let courage, rank, skill: Int
    let id: String
    let name: String
    let team: Team
    let teamIcon: String

    // Dependency Injection (DI)
    init(transformer: Transformer) {
        self.courage = transformer.courage ?? 0
        self.rank = transformer.rank ?? 0
        self.skill = transformer.skill ?? 0
        self.endurance = transformer.endurance ?? 0
        self.firepower = transformer.firepower ?? 0
        self.intelligence = transformer.intelligence ?? 0
        self.speed = transformer.speed ?? 0
        self.strength = transformer.strength ?? 0
        self.id = transformer.id ?? ""
        self.name = transformer.name ?? ""
        self.teamIcon = transformer.teamIcon ?? ""
        self.overallRating = self.endurance + self.firepower + self.intelligence + self.speed + self.strength

        if transformer.team == Team.autobots.rawValue {
            self.team = .autobots
        } else {
            self.team = .decepticons
        }
    }

}
