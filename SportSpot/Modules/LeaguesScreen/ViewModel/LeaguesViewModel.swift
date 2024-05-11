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
    var network : NetworkService
    var bindLeaguesToViewController : (()->()) = {}
    
    var leagues : [League]?
    var resultToSearch : Int?
    
    init(network:NetworkService){
        self.network = network
    }
    
    func loadLeagues(from sportType: SportType){
        network.fetchLeagues(from: sportType) { [weak self] result in
            switch result{
            case .success(let leaguesResponse):
                DispatchQueue.main.async{
                    self?.leagues = leaguesResponse.result
                    self?.bindLeaguesToViewController()
                }
            case .failure(_):
                print("failure")
            }
        }
    }
    
    func getFootballLeaguesResult () -> [League]{
        return leagues ?? []
    }

    func passValueToleagueScreen(value: Int){
        resultToSearch = value
    }

}
