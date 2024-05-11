//
//  NetworkService.swift
//  SportSpot
//
//  Created by Aser Eid on 10/05/2024.
//

import Foundation
import Alamofire

class NetworkService {
    func fetchCricketLeagues(url : String ,completion: @escaping (Result<CricketResponse, Error>) -> Void) {
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let leagueResponse = try decoder.decode(CricketResponse.self, from: data)
                    completion(.success(leagueResponse))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func fetchTennisLeagues(url : String ,completion: @escaping (Result<TennisLeagueResponse, Error>) -> Void) {
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let leagueResponse = try decoder.decode(TennisLeagueResponse.self, from: data)
                    completion(.success(leagueResponse))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func fetchBasketballLeagues(url : String ,completion: @escaping (Result<BasketBallResponse, Error>) -> Void) {
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let leagueResponse = try decoder.decode(BasketBallResponse.self, from: data)
                    completion(.success(leagueResponse))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func fetchFootballLeagues(url : String ,completion: @escaping (Result<LeagueResponse, Error>) -> Void) {
        
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
    
    
    
//    func fetchFootballLeagues<T>(from url : String , responseType: T.Type,completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable{
//        
//        AF.request(url).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    let decoder = JSONDecoder()
//                    let leagueResponse = try decoder.decode(T.self, from: data)
//                    completion(.success(leagueResponse))
//                } catch {
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//            
//        }
//    }
}
