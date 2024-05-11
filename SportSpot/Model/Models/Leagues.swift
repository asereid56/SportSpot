//
//  FootballLeagues.swift
//  SportSpot
//
//  Created by Aser Eid on 10/05/2024.
//

import Foundation

struct LeagueResponse: Codable {
    let success: Int
    let result: [League]
}

struct League:Codable {
    let leagueKey: Int
    let leagueName: String
    let countryKey: Int?
    let countryName: String?
    let leagueLogo: URL?
    let countryLogo: URL?
    let leagueYear: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
        case leagueYear = "league_year"
    }
}
