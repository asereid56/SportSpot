//
//  LeaguesViewModel.swift
//  SportSpot
//
//  Created by Aser Eid on 11/05/2024.
//

import Foundation

class LeaguesViewModel {
    var leaguesViewModel : LeaguesViewModel?
    var network : NetworkService
    var bindLeaguesToViewController : (()->()) = {}
    
    var Footballleagues : [League]?
    var Basketballleagues : [BasketBall]?
    var tennisleagues : [TennisLeague]?
    var cricketleagues : [Cricket]?
    var resultToSearch : Int?
    
    init(network:NetworkService){
        self.network = network
    }
    
    func loadFootballLeagues(from url : String ){
        network.fetchFootballLeagues(url: url) { [weak self] result in
            switch result{
            case .success(let leaguesResponse):
                DispatchQueue.main.async{
                    self?.Footballleagues = leaguesResponse.result
                    self?.bindLeaguesToViewController()
                }
            case .failure(_):
                print("failure")
            }
        }
    }
    func loadTennisLeagues(from url : String ){
        network.fetchTennisLeagues(url: url) { [weak self] result in
            switch result{
            case .success(let leaguesResponse):
                DispatchQueue.main.async{
                    self?.tennisleagues = leaguesResponse.result
                    self?.bindLeaguesToViewController()
                }
            case .failure(_):
                print("failure")
            }
        }
    }
 
    
    func getFootballLeaguesResult () -> [League]{
        return Footballleagues ?? []
    }
    
    func passValueToleagueScreen(value: Int){
        resultToSearch = value
    }

}
