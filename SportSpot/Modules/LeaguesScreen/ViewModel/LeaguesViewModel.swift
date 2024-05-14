//
//  LeaguesViewModel.swift
//  SportSpot
//
//  Created by Aser Eid on 11/05/2024.
//

import Foundation

protocol PassSportsType {
    func passSportTypeToleagueScreen(value: SportType)
}

class LeaguesViewModel: PassSportsType {
    
    private var network : Servicing
    var bindLeaguesToViewController : (()->()) = {}
    
    private var leagues : [League]?
    private var sportType : SportType?
    
    init(network: Servicing){
        self.network = network
    }
    
    func loadLeagues(from sportType: SportType){
        network.fetchData(sportType: sportType, methodName: .Leagues, id: nil, fromDate: nil, toDate: nil, firstTeamId: nil, secondTeamId: nil) { [weak self] response in
            switch response{
            case .success(let data):
                DispatchQueue.main.async{
                    print(data)
                    if let leaguesResponse: Response<League> = Utils.convertTo(from: data){
                        self?.leagues = leaguesResponse.result
                        self?.bindLeaguesToViewController()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getFootballLeaguesResult () -> [League]{
        return leagues ?? []
    }

    func passSportTypeToleagueScreen(value: SportType){
        sportType = value
    }

    func getSportType() -> SportType {
        return sportType ?? .football
    }
    
    func passValueToLeagueDetailsScreen(value : Int ,leagueDetailsViewModel : PassLeagueDetails){
        leagueDetailsViewModel.passLeagueIdToleagueDetailsScreen(value: value, sportType: getSportType())
    }
}
