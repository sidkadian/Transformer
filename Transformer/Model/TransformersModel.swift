//
//  TransformersModel.swift
//  Transformer
//
//  Created by Siddharth kadian on 17/02/21.
//

import Foundation

// MARK: - Transformer Model
struct TransformerModel: Codable {
    let transformers: [Transformer]
}

struct Transformer: Codable, Equatable {
    let courage, endurance, firepower: Int?
    let id: String?
    let intelligence: Int?
    let name: String?
    let rank, skill, speed, strength: Int?
    let team: String?
    let teamIcon: String?

    enum CodingKeys: String, CodingKey {
        case courage, endurance, firepower, id, intelligence, name, rank, skill, speed, strength, team
        case teamIcon = "team_icon"
    }
}

// MARK: - EmptyModel
struct EmptyTransformerModel: Codable {}
