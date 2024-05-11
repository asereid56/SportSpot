//
//  NetworkService.swift
//  SportSpot
//
//  Created by Aser Eid on 10/05/2024.
//

import Foundation
import Alamofire

class NetworkService {
    
    func fetchLeagues(from sportType: SportType ,completion: @escaping (Result<LeagueResponse, Error>) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sportType.rawValue)/?met=Leagues&APIkey=203e9e88fd9286c952d92229a24ae359aa3f9a98ea206c1c7355f9f04a8a9899"
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let leagueResponse = try decoder.decode(LeagueResponse.self, from: data)
                    completion(.success(leagueResponse))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
