//
//  Utils.swift
//  SportSpot
//
//  Created by Aser Eid on 10/05/2024.
//

import Foundation

struct Utils {
    
    static func convertTo<T: Decodable>(from data: Data)-> T?{
        do {
            let decoder = JSONDecoder()
            let leagueResponse = try decoder.decode(T.self, from: data)
            return leagueResponse
        } catch {
            return nil
        }
    }
    
}

enum SportType: String {
    case football
    case basketball
    case tennis
    case cricket
}

enum MethodName: String {
    case Countries
    case Leagues
    case Fixtures = "Fixtures&leagueId="
    case H2H
    case Livescore
    case Standings = "Standings&leagueId="
    case Topscorers = "Topscorers&leagueId="
    case Teams = "Teams&teamId="
    case Players = "Players&playerId="
    case Videos = "Videos&eventId="
    case Odds = "Odds&matchId="
    case Probabilities = "Probabilities&matchId="
    case OddsLive
    case Comments = "Comments&matchId="
}

