//
//  MockSevrvicesest.swift
//  SportSpotTests
//
//  Created by Mac on 16/05/2024.
//

import XCTest
@testable import SportSpot

final class MockTest: XCTestCase {
    
    var networkService: MockService!
    
    override func setUp() {
        super.setUp()
        networkService = MockService(shouldReturnError: false)
    }

    override func tearDown() {
        networkService = nil
        super.tearDown()
    }

    func testFetchData() {

        let sportType: SportType = .football
        let methodName: MethodName = .Leagues
        let id: Int? = nil
        

        networkService.fetchData(sportType: sportType, methodName: methodName) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Data should not be nil")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }

    func testFetchCountries() {
        let methodName: MethodName = .Countries
        
        networkService.fetchData(sportType: .football, methodName: methodName) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Data should not be nil")

            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }

    func testFetchLeagues() {
        let methodName: MethodName = .Leagues
        
        networkService.fetchData(sportType: .football, methodName: methodName) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Data should not be nil")

            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }

    func testFetchFixtures() {
        let methodName: MethodName = .Fixtures
        let fromDate = "2021-05-18"
        let toDate = "2021-05-18"
        
        networkService.fetchData(sportType: .football, methodName: methodName, fromDate: fromDate, toDate: toDate) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Data should not be nil")

            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
}

class MockService: Servicing {
    
    var shouldReturnError: Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    func fetchData(sportType: SportType,methodName: MethodName, id: Int? = nil, fromDate: String? = nil, toDate:String? = nil, firstTeamId: Int? = nil, secondTeamId:Int? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
        
        var data = Data()
        do {
            data = try JSONSerialization.data(withJSONObject: fakeJsonObj)
        } catch let error {
            print(error.localizedDescription)
        }
        
        enum ResponseWithError: Error {
            case responseError
        }
        
        if shouldReturnError {
            completion(.failure(ResponseWithError.responseError))
        } else {
            completion(.success(data))
        }
    }
    
    let fakeJsonObj: [String: Any] = [
        "success": 1,
        "result": [
            "event_key": 1243320,
            "event_date": "2024-05-13",
            "event_time": "20:45",
            "event_home_team": "Fiorentina",
            "home_team_key": 4974,
            "event_away_team": "Monza",
            "away_team_key": 4990,
            "event_halftime_result": "1 - 1",
            "event_final_result": "2 - 1",
            "event_ft_result": "2 - 1",
            "event_penalty_result": "",
            "event_status": "Finished",
            "country_name": "Italy",
            "league_name": "Serie A",
            "league_key": 207,
            "league_round": "Round 36",
            "league_season": "2023/2024",
            "event_live": "0",
            "event_stadium": "Stadio Artemio Franchi (Firenze)",
            "event_referee": "L. Zufferli",
            "home_team_logo": "https://apiv2.allsportsapi.com/logo/4974_fiorentina.jpg",
            "away_team_logo": "https://apiv2.allsportsapi.com/logo/4990_monza.jpg",
            "event_country_key": 5,
            "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/207_serie-a.png",
            "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/5_italy.png",
            "event_home_formation": "4-2-3-1",
            "event_away_formation": "4-4-2",
            "fk_stage_key": 331,
            "stage_name": "Current",
            "league_group": nil,
            "goalscorers": [
                [
                    "time": "9",
                    "home_scorer": "",
                    "home_scorer_id": "",
                    "home_assist": "",
                    "home_assist_id": "",
                    "score": "0 - 1",
                    "away_scorer": "M. Djuric",
                    "away_scorer_id": "3519241526",
                    "away_assist": "D. Mota",
                    "away_assist_id": "928971081",
                    "info": "",
                    "info_time": "1st Half"
                ],
                [
                    "time": "32",
                    "home_scorer": "N. Gonzalez",
                    "home_scorer_id": "379872929",
                    "home_assist": "A. Barak",
                    "home_assist_id": "1956055230",
                    "score": "1 - 1",
                    "away_scorer": "",
                    "away_scorer_id": "",
                    "away_assist": "",
                    "away_assist_id": "",
                    "info": "",
                    "info_time": "1st Half"
                ],
                [
                    "time": "78",
                    "home_scorer": "Arthur Melo",
                    "home_scorer_id": "972667204",
                    "home_assist": "A. Barak",
                    "home_assist_id": "1956055230",
                    "score": "2 - 1",
                    "away_scorer": "",
                    "away_scorer_id": "",
                    "away_assist": "",
                    "away_assist_id": "",
                    "info": "",
                    "info_time": "2nd Half"
                ]
            ],
            "substitutes": [
                [
                    "time": "73",
                    "home_scorer": [],
                    "home_assist": nil,
                    "score": "substitution",
                    "away_scorer": [
                        "in": "D. D'Ambrosio",
                        "out": "Pablo Marí",
                        "in_id": 1858181532,
                        "out_id": 3518193852
                    ],
                    "away_assist": nil,
                    "info": nil,
                    "info_time": "2nd Half"
                ],
                [
                    "time": "82",
                    "home_scorer": [],
                    "home_assist": nil,
                    "score": "substitution",
                    "away_scorer": [
                        "in": "V. Carboni",
                        "out": "A. Colpani",
                        "in_id": 920627414,
                        "out_id": 818864052
                    ],
                    "away_assist": nil,
                    "info": nil,
                    "info_time": "2nd Half"
                ],
                [
                    "time": "80",
                    "home_scorer": [
                        "in": "A. Duncan",
                        "out": "F. Parisi",
                        "in_id": 4204789523,
                        "out_id": 1271406021
                    ],
                    "home_assist": nil,
                    "score": "substitution",
                    "away_scorer": [],
                    "away_assist": nil,
                    "info": nil,
                    "info_time": "2nd Half"
                ],
                [
                    "time": "74",
                    "home_scorer": [
                        "in": "L. Beltrán",
                        "out": "G. Castrovilli",
                        "in_id": 212166179,
                        "out_id": 3998714721
                    ],
                    "home_assist": nil,
                    "score": "substitution",
                    "away_scorer": [],
                    "away_assist": nil,
                    "info": nil,
                    "info_time": "2nd Half"
                ]
            ],
            "cards": [
                [
                    "time": "41",
                    "home_fault": "F. Parisi",
                    "card": "yellow card",
                    "away_fault": "",
                    "info": "",
                    "home_player_id": "1271406021",
                    "away_player_id": "",
                    "info_time": "1st Half"
                ],
                [
                    "time": "69",
                    "home_fault": "",
                    "card": "yellow card",
                    "away_fault": "W. Bondo",
                    "info": "",
                    "home_player_id": "",
                    "away_player_id": "3276648875",
                    "info_time": "2nd Half"
                ]
            ],
            "vars": [
                "home_team": [],
                "away_team": []
            ],
            "lineups": [
                "home_team": [
                    "starting_lineups": [
                        [
                            "player": "Antonín Barák",
                            "player_number": 72,
                            "player_position": 9,
                            "player_country": nil,
                            "player_key": 1956055230,
                            "info_time": ""
                        ],
                        [
                            "player": "Arthur",
                            "player_number": 6,
                            "player_position": 6,
                            "player_country": nil,
                            "player_key": 972667204,
                            "info_time": ""
                        ],
                        [
                            "player": "Fabiano Parisi",
                            "player_number": 65,
                            "player_position": 5,
                            "player_country": nil,
                            "player_key": 1271406021,
                            "info_time": ""
                        ],
                        [
                            "player": "Gaetano Castrovilli",
                            "player_number": 17,
                            "player_position": 10,
                            "player_country": nil,
                            "player_key": 3998714721,
                            "info_time": ""
                        ],
                        [
                            "player": "Lucas Martínez Quarta",
                            "player_number": 28,
                            "player_position": 3,
                            "player_country": nil,
                            "player_key": 1133502755,
                            "info_time": ""
                        ],
                        [
                            "player": "M'Bala Nzola",
                            "player_number": 18,
                            "player_position": 11,
                            "player_country": nil,
                            "player_key": 1696123209,
                            "info_time": ""
                        ],
                        [
                            "player": "Michael Kayode",
                            "player_number": 33,
                            "player_position": 2,
                            "player_country": nil,
                            "player_key": 3603679670,
                            "info_time": ""
                        ],
                        [
                            "player": "Nicolás González",
                            "player_number": 10,
                            "player_position": 8,
                            "player_country": nil,
                            "player_key": 379872929,
                            "info_time": ""
                        ],
                        [
                            "player": "Nikola Milenkovic",
                            "player_number": 4,
                            "player_position": 4,
                            "player_country": nil,
                            "player_key": 1940621692,
                            "info_time": ""
                        ],
                        [
                            "player": "Pietro Terracciano",
                            "player_number": 1,
                            "player_position": 1,
                            "player_country": nil,
                            "player_key": 1999368287,
                            "info_time": ""
                        ],
                        [
                            "player": "Rolando Mandragora",
                            "player_number": 38,
                            "player_position": 7,
                            "player_country": nil,
                            "player_key": 1380760679,
                            "info_time": ""
                        ]
                    ],
                    "substitutes": [
                        [
                            "player": "Alfred Duncan",
                            "player_number": 32,
                            "player_position": 0,
                            "player_country": nil,
                            "player_key": 4204789523,
                            "info_time": ""
                        ],
                        [
                            "player": "Christian Kouamé",
                            "player_number": 99,
                            "player_position": 0,
                            "player_country": nil,
                            "player_key": 2740618480,
                            "info_time": ""
                        ],
                        [
                            "player": "Cristiano Biraghi",
                            "player_number": 3,
                            "player_position": 0,
                            "player_country": nil,
                            "player_key": 2588728101,
                            "info_time": ""
                        ],
                        [
                            "player": "Davide Faraoni",
                            "player_number": 22,
                            "player_position": 0,
                            "player_country": nil,
                            "player_key": 232443902,
                            "info_time": ""
                        ],
                        [
                            "player": "Dodô",
                            "player_number": 2,
                            "player_position": 0,
                            "player_country": nil,
                            "player_key": 2266900382,
                            "info_time": ""
                        ],
                        [
                            "player": "Giacomo Bonaventura",
                            "player_number": 5,
                            "player_position": 0,
                            "player_country": nil,
                            "player_key": 1915699434,
                            "info_time": ""
                        ],
                        [
                            "player": "Tommaso Martinelli",
                            "player_number": 30,
                            "player_position": 0,
                            "player_country": nil,
                            "player_key": 2435737122,
                            "info_time": ""
                        ]
                    ],
                    "coaches": [
                        [
                            "coache": "V. Italiano",
                            "coache_country": nil
                        ]
                    ],
                    "missing_players": []
                ],
                "away_team": [
                    "starting_lineups": [
                        [
                            "player": "Alessio Zerbin",
                            "player_number": 20,
                            "player_position": 9,
                            "player_country": nil,
                            "player_key": 657269409,
                            "info_time": ""
                        ],
                        [
                            "player": "Andrea Colpani",
                            "player_number": 28,
                            "player_position": 6,
                            "player_country": nil,
                            "player_key": 818864052,
                            "info_time": ""
                        ],
                        [
                            "player": "Armando Izzo",
                            "player_number": 4,
                            "player_position": 3,
                            "player_country": nil,
                            "player_key": 3292395742,
                            "info_time": ""
                        ],
                        [
                            "player": "Dany Mota",
                            "player_number": 47,
                            "player_position": 11,
                            "player_country": nil,
                            "player_key": 928971081,
                            "info_time": ""
                        ],
                        [
                            "player": "Georgios Kyriakopoulos",
                            "player_number": 77,
                            "player_position": 5,
                            "player_country": nil,
                            "player_key": 2742363721,
                            "info_time": ""
                        ],
                        [
                            "player": "Matteo Pessina",
                            "player_number": 32,
                            "player_position": 7,
                            "player_country": nil,
                            "player_key": 2507416400,
                            "info_time": ""
                        ],
                        [
                            "player": "Michele Di Gregorio",
                            "player_number": 16,
                            "player_position": 1,
                            "player_country": nil,
                            "player_key": 700014087,
                            "info_time": ""
                        ],
                        [
                            "player": "Milan Duric",
                            "player_number": 11,
                            "player_position": 10,
                            "player_country": nil,
                            "player_key": 3519241526,
                            "info_time": ""
                        ],
                        [
                            "player": "Pablo Marí",
                            "player_number": 22,
                            "player_position": 4,
                            "player_country": nil,
                            "player_key": 3518193852,
                            "info_time": ""
                        ],
                        [
                            "player": "Samuele Birindelli",
                            "player_number": 19,
                            "player_position": 2,
                            "player_country": nil,
                            "player_key": 1224406419,
                            "info_time": ""
                        ],
                        [
                            "player": "Warren Bondo",
                            "player_number": 38,
                            "player_position": 8,
                            "player_country": nil,
                            "player_key": 3276648875,
                            "info_time": ""
                        ]
                    ],
                    "substitutes": [
                        [
                            "player": "Alessandro Sorrentino",
                            "player_number": 23,
                            "player_position": 0,
                            "player_country": nil,
                            "player_key": 782195230,
                            "info_time": ""
                        ],
                        [
                            "player": "Andrea Ferraris",
                            "player_number": 61,
                            "player_position": 0,
                            "player_country": nil,
                            "player_key": 3934767042,
                            "info_time": ""
                        ],
                        [
                            "player": "Danilo D'Ambrosio",
                            "player_number": 33,
                            "player_position": 0,
                            "player_country": nil,
                            "player_key": 1858181532,
                            "info_time": ""
                        ],
                        [
                            "player": "Gianluca Caprari",
                            "player_number": 10,
                            "player_position": 0,
                            "player_country": nil,
                            "player_key": 3546408474,
                            "info_time": ""
                        ],
                        [
                            "player": "Giulio Donati",
                            "player_number": 2,
                            "player_position": 0,
                            "player_country": nil,
                            "player_key": 686088871,
                            "info_time": ""
                        ],
                        [
                            "player": "Jean-Daniel Akpa Akpro",
                            "player_number": 8,
                            "player_position": 0,
                            "player_country": nil,
                            "player_key": 3855407745,
                            "info_time": ""
                        ],
                        [
                            "player": "Lorenzo Colombo",
                            "player_number": 9,
                            "player_position": 0,
                            "player_country": nil,
                            "player_key": 1021494156,
                            "info_time": ""
                        ],
                        [
                            "player": "Valentín Carboni",
                            "player_number": 21,
                            "player_position": 0,
                            "player_country": nil,
                            "player_key": 920627414,
                            "info_time": ""
                        ]
                    ],
                    "coaches": [
                        [
                            "coache": "R. Palladino",
                            "coache_country": nil
                        ]
                    ],
                    "missing_players": []
                ]
            ],
            "statistics": [
                [
                    "type": "Substitution",
                    "home": "5",
                    "away": "5"
                ],
                [
                    "type": "Shots Total",
                    "home": "15",
                    "away": "6"
                ],
                [
                    "type": "Shots On Goal",
                    "home": "8",
                    "away": "2"
                ],
                [
                    "type": "Shots Off Goal",
                    "home": "2",
                    "away": "3"
                ],
                [
                    "type": "Shots Blocked",
                    "home": "5",
                    "away": "1"
                ],
                [
                    "type": "Shots Inside Box",
                    "home": "10",
                    "away": "6"
                ],
                [
                    "type": "Shots Outside Box",
                    "home": "5",
                    "away": "0"
                ],
                [
                    "type": "Saves",
                    "home": "1",
                    "away": "6"
                ],
                [
                    "type": "Passes Total",
                    "home": "401",
                    "away": "417"
                ],
                [
                    "type": "Passes Accurate",
                    "home": "349",
                    "away": "355"
                ]
            ]
        ]
    ]

}
