//
//  WorldCup.swift
//  cupchampions
//
//  Created by Anderson Mendes de Almeida on 06/11/21.
//

import Foundation

struct WorldCup: Codable {
   
    let year: Int
    let country: String
    let winner: String
    let vice: String
    let winnerScore: String
    let viceScore: String
    let matches: [Match]
}

extension WorldCup: Hashable {
    static func == (lhs: WorldCup, rhs: WorldCup) -> Bool {
        return lhs.winner == rhs.winner
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(winner)
    }
}
