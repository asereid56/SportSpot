//
//  TeamDetailsViewModel.swift
//  SportSpot
//
//  Created by Aser Eid on 15/05/2024.
//

import Foundation

protocol PassTeamDetails {
    func passTeamToTeamsDetailsScreen(value: Int,for sportType: SportType)
}

class TeamDetailsViewModel : PassTeamDetails {
    
    
    private var network : Servicing
    private var teamKey : Int?
    private var team: Team?
    private var sportType: SportType?
    var bindingTeamDetails : (() -> ()) = {}
    
    init(network: Servicing) {
        self.network = network
    }
    
    func loadTeamData(){
        print("call the data")
        network.fetchData(sportType: sportType ?? .football, methodName: .Teams, id: teamKey, fromDate: nil, toDate: nil, firstTeamId: nil, secondTeamId: nil) { [weak self] response in
            switch response{
            case .success(let data):
                print("dataaaaaa \(data)")
                if let response: Response<Team> = Utils.convertTo(from: data){
                    print("LatestEvents\(data)")
                    self?.team = response.result?.first
                    print(self?.team)
                    self?.bindingTeamDetails()
                }else{
                    print("Can't convert the data: \(data)")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func passTeamToTeamsDetailsScreen(value: Int,for sportType: SportType) {
        teamKey = value
        self.sportType = sportType
    }
    
    func getTheTeam() -> Team? {
        return team
    }
}
