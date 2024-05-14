//
//  FootballLeagues.swift
//  SportSpot
//
//  Created by Aser Eid on 10/05/2024.
//

import Foundation

struct Response<T:Codable>: Codable {
    let success : Int?
    let result : [T]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case result = "result"
    }
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

// MARK: - Result
struct MatchDetails: Codable {
    let eventKey: Int?
    let eventDate, eventTime: String?
    let eventHomeTeam: String?
    let homeTeamKey: Int?
    let eventAwayTeam: String?
    let awayTeamKey: Int?
    let eventHalftimeResult: String?
    let eventFinalResult: String?
    let eventFtResult: String?
    let eventPenaltyResult: String?
    let eventStatus: String?
    let countryName: String?
    let leagueName: String?
    let leagueKey: Int?
    let leagueRound: String?
    let leagueSeason: String?
    let eventLive: String?
    let eventStadium: String?
    let eventReferee: String?
    let homeTeamLogo: URL?
    let awayTeamLogo: URL?
    let eventCountryKey: Int?
    let leagueLogo: URL?
    let countryLogo: URL?
    let eventHomeFormation: String?
    let eventAwayFormation: String?
    let fkStageKey: Int?
    let stageName: String?
    let leagueGroup: JSONNull?
    let goalscorers: [GoalDetails]?
    let substitutes: [Substitute]?
    let cards: [CardElement]?
    let vars: Vars?
    let lineups: Lineups?
    let statistics: [Statistic]?

    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventHalftimeResult = "event_halftime_result"
        case eventFinalResult = "event_final_result"
        case eventFtResult = "event_ft_result"
        case eventPenaltyResult = "event_penalty_result"
        case eventStatus = "event_status"
        case countryName = "country_name"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case leagueRound = "league_round"
        case leagueSeason = "league_season"
        case eventLive = "event_live"
        case eventStadium = "event_stadium"
        case eventReferee = "event_referee"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case eventCountryKey = "event_country_key"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
        case eventHomeFormation = "event_home_formation"
        case eventAwayFormation = "event_away_formation"
        case fkStageKey = "fk_stage_key"
        case stageName = "stage_name"
        case leagueGroup = "league_group"
        case goalscorers, substitutes, cards, vars, lineups, statistics
    }
}

struct GoalDetails: Codable {
    let time: String?
    let homeScorer: String?
    let homeScorerId: String?
    let homeAssist: String?
    let homeAssistId: String?
    let score: String?
    let awayScorer: String?
    let awayScorerId: String?
    let awayAssist: String?
    let awayAssistId: String?
    let info: String?
    let infoTime: String?
    
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case homeScorer = "home_scorer"
        case homeScorerId = "home_scorer_id"
        case homeAssist = "home_assist"
        case homeAssistId = "home_assist_id"
        case score = "score"
        case awayScorer = "away_scorer"
        case awayScorerId = "away_scorer_id"
        case awayAssist = "away_assist"
        case awayAssistId = "away_assist_id"
        case info = "info"
        case infoTime = "info_time"
    }
}


// MARK: - CardElement
struct CardElement: Codable {
    let time: String?
    let homeFault: String?
    let card: String?
    let awayFault: String?
    let info: String?
    let homePlayerID, awayPlayerID: String?
    let infoTime: String?

    enum CodingKeys: String, CodingKey {
        case time
        case homeFault = "home_fault"
        case card
        case awayFault = "away_fault"
        case info
        case homePlayerID = "home_player_id"
        case awayPlayerID = "away_player_id"
        case infoTime = "info_time"
    }
}

// MARK: - Lineups
struct Lineups: Codable {
    let homeTeam, awayTeam: LineupTeam?

    enum CodingKeys: String, CodingKey {
        case homeTeam = "home_team"
        case awayTeam = "away_team"
    }
}

// MARK: - LineupTeam
struct LineupTeam: Codable {
    let startingLineups, substitutes: [StartingLineup]?
    let coaches: [Coach]?
    let missingPlayers: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case startingLineups = "starting_lineups"
        case substitutes, coaches
        case missingPlayers = "missing_players"
    }
}

// MARK: - Coach
struct Coach: Codable {
    let coache: String?
    let coacheCountry: JSONNull?

    enum CodingKeys: String, CodingKey {
        case coache
        case coacheCountry = "coache_country"
    }
}

// MARK: - StartingLineup
struct StartingLineup: Codable {
    let player: String?
    let playerNumber, playerPosition: Int?
    let playerCountry: JSONNull?
    let playerKey: Int?
    let infoTime: String?

    enum CodingKeys: String, CodingKey {
        case player
        case playerNumber = "player_number"
        case playerPosition = "player_position"
        case playerCountry = "player_country"
        case playerKey = "player_key"
        case infoTime = "info_time"
    }
}

// MARK: - Statistic
struct Statistic: Codable {
    let type: String?
    let home, away: String?
}

// MARK: - Substitute
struct Substitute: Codable {
    let time: String?
    let homeScorer: ScorerUnion?
    let homeAssist: String?
    let score: String?
    let awayScorer: ScorerUnion?
    let awayAssist: String?
    let info: String?
    let infoTime: String?

    enum CodingKeys: String, CodingKey {
        case time
        case homeScorer = "home_scorer"
        case homeAssist = "home_assist"
        case score
        case awayScorer = "away_scorer"
        case awayAssist = "away_assist"
        case info
        case infoTime = "info_time"
    }
}

enum ScorerUnion: Codable {
    case anythingArray([JSONAny])
    case scorerClass(ScorerClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONAny].self) {
            self = .anythingArray(x)
            return
        }
        if let x = try? container.decode(ScorerClass.self) {
            self = .scorerClass(x)
            return
        }
        throw DecodingError.typeMismatch(ScorerUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ScorerUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .anythingArray(let x):
            try container.encode(x)
        case .scorerClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - AwayScorerClass
struct ScorerClass: Codable {
    let scorerIn, out: String?
    let inID, outID: Int?

    enum CodingKeys: String, CodingKey {
        case scorerIn = "in"
        case out
        case inID = "in_id"
        case outID = "out_id"
    }
}

// MARK: - Vars
struct Vars: Codable {
    let homeTeam, awayTeam: [TeamElement]?

    enum CodingKeys: String, CodingKey {
        case homeTeam = "home_team"
        case awayTeam = "away_team"
    }
}

// MARK: - TeamElement
struct TeamElement: Codable {
    let varPlayerName, varMinute: String?
    let varPlayerID: Int?
    let varType, varEventDecision: String?
    let varDecision: VarDecision?

    enum CodingKeys: String, CodingKey {
        case varPlayerName = "var_player_name"
        case varMinute = "var_minute"
        case varPlayerID = "var_player_id"
        case varType = "var_type"
        case varEventDecision = "var_event_decision"
        case varDecision = "var_decision"
    }
}

enum VarDecision: String, Codable {
    case False = "False"
    case True = "True"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
