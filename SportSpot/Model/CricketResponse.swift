//
//  CricketResponse.swift
//  SportSpot
//
//  Created by Aser Eid on 11/05/2024.
//

import Foundation
struct CricketResponse: Codable {
    let success: Int
    let result: [League]
}

struct Cricket: Codable {
    let leagueKey: Int
    let leagueName: String
    let leagueYear: String

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case leagueYear = "league_year"
    }
}
