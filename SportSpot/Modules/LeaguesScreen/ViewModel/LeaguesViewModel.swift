//
//  LeaguesViewModel.swift
//  SportSpot
//
//  Created by Aser Eid on 11/05/2024.
//

import Foundation

protocol PassSportsType {
    func passValueToleagueScreen(value: Int)
}

class LeaguesViewModel: PassSportsType {
    
    private var network : Servicing
    var bindLeaguesToViewController : (()->()) = {}
    
    private var leagues : [League]?
    var resultToSearch : Int?
    
    init(network: Servicing){
        self.network = network
    }
    
    func loadLeagues(from sportType: SportType){
        network.fetchData(sportType: sportType, methodName: .Leagues, id: nil, fromDate: nil, toDate: nil, firstTeamId: nil, secondTeamId: nil) { [weak self] response in
            switch response{
            case .success(let data):
                DispatchQueue.main.async{
                    print(data)
                    if let leaguesResponse: LeagueResponse = Utils.convertTo(from: data){
                        self?.leagues = leaguesResponse.result
                        self?.bindLeaguesToViewController()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadLeaguesFixtures(from sportType: SportType, for id:Int, fromDate: String, toDate: String){
        network.fetchData(sportType: sportType, methodName: .Fixtures, id: id, fromDate: fromDate, toDate: toDate, firstTeamId: nil, secondTeamId: nil) { data in
            print(data)
        }
    }
    
    func getFootballLeaguesResult () -> [League]{
        return leagues ?? []
    }

    func passValueToleagueScreen(value: Int){
        resultToSearch = value
    }

}
