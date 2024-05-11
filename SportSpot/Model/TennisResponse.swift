//
//  TennisResponse.swift
//  SportSpot
//
//  Created by Aser Eid on 11/05/2024.
//

import Foundation
struct TennisLeagueResponse: Codable {
    let success: Int
    let result: [TennisLeague]
}

struct TennisLeague: Codable {
    let leagueKey: Int
    let leagueName: String
    let countryKey: Int
    let countryName: String

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
    }
}
