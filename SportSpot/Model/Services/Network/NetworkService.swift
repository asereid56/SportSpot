//
//  NetworkService.swift
//  SportSpot
//
//  Created by Aser Eid on 10/05/2024.
//

import Foundation
import Alamofire

protocol Servicing {
    func fetchData(sportType: SportType,methodName: MethodName, id: Int?, fromDate: String?, toDate:String?, firstTeamId: Int?, secondTeamId:Int?, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkService: Servicing {
    
    private let APIkey = "203e9e88fd9286c952d92229a24ae359aa3f9a98ea206c1c7355f9f04a8a9899"
    private let urlPath = "https://apiv2.allsportsapi.com/"
    
    func fetchData(sportType: SportType,methodName: MethodName, id: Int? = nil, fromDate: String? = nil, toDate:String? = nil, firstTeamId: Int? = nil, secondTeamId:Int? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
        var url = "\(urlPath)\(sportType.rawValue)/?APIkey=\(APIkey)&met=\(methodName.rawValue)"
        
        if let id{
            url += "\(id)"
        }
        if let fromDate, let toDate{
            url += "&from=\(fromDate)&to=\(toDate)"
        }
        if let firstTeamId, let secondTeamId{
            url += "&firstTeamId=\(firstTeamId)&secondTeamId=\(secondTeamId)"
        }
        
        print(url)
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

//    func fetchLeagues(from sportType: SportType ,completion: @escaping (Result<LeagueResponse, Error>) -> Void) {
//        let url = "\(urlPath)\(sportType.rawValue)/?met=Leagues&APIkey=\(APIkey)"
//        AF.request(url).responseData { response in
//            switch response.result {
//            case .success(let data):
//                
//                do {
//                    let decoder = JSONDecoder()
//                    let leagueResponse = try decoder.decode(LeagueResponse.self, from: data)
//                    completion(.success(leagueResponse))
//                } catch {
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
}
