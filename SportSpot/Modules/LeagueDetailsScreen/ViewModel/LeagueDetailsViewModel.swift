//
//  LeagueDetailsViewModel.swift
//  SportSpot
//
//  Created by Mac on 13/05/2024.
//

import Foundation


protocol PassLeagueDetails {
    func passLeagueIdToleagueDetailsScreen(value: Int, sportType: SportType)
}

class LeagueDetailsViewModel: PassLeagueDetails{
    
    private var network : Servicing
    var bindUpcomingEventsToViewController : (()->()) = {}
    var bindLatestEventsToViewController : (()->()) = {}

    private var upcomingEvents : [MatchDetails]?
    private var latestEvents : [MatchDetails]?
    private var teamsDetails : [TeamDetails] = []
    
    private var sportType: SportType?
    private var leagueId : Int?

    init(network: Servicing) {
        self.network = network
    }

    private func loadLeaguesFixtures(from sportType: SportType, for id:Int, fromDate: String, toDate: String, complation:@escaping (Data)->Void ){
        print("call the data")
        network.fetchData(sportType: sportType, methodName: .Fixtures, id: id, fromDate: fromDate, toDate: toDate, firstTeamId: nil, secondTeamId: nil) {[weak self] response in
            switch response{
            case .success(let data):
                complation(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadLatestEvents(){
        
        let toDay = Date().description.split(separator: " ")[0]
        let pastDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date())!.description.split(separator: " ")[0]
        
        loadLeaguesFixtures(from: sportType ?? .football, for: 6 , fromDate: String(pastDate), toDate: String(toDay)){ [weak self] data in
            print("loadLatestEvents")
            
            if let response: Response<MatchDetails> = Utils.convertTo(from: data){
                print("LatestEvents\(data)")
                print(response.result)
                self?.latestEvents = response.result
                self?.loadTeamsDetails()
                self?.bindLatestEventsToViewController()
            }else{
                print("Can't convert the data: \(data)")
            }
        }
    }
    
    func loadUpcomingEvents(){
        
        let toDay = Date().description.split(separator: " ")[0]
        let nextDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date())!.description.split(separator: " ")[0]
        
        loadLeaguesFixtures(from: sportType ?? .football, for: 6, fromDate: String(toDay), toDate: String(nextDate)){ [weak self] data in
            print("loadUpcomingEvents\(data)")
            if let response: Response<MatchDetails> = Utils.convertTo(from: data){
                print(response.result!)
                self?.upcomingEvents = response.result
                self?.loadTeamsDetails()
                self?.bindUpcomingEventsToViewController()
            }
        }
    }
    
    func passLeagueIdToleagueDetailsScreen(value: Int, sportType: SportType) {
        leagueId = value
        self.sportType = sportType
    }
    
    func getSportType() -> SportType {
        return sportType ?? .football
    }
    
    func getLeagueId() -> Int {
        return leagueId ?? 0
    }
    
    func getLatestEvents() -> [MatchDetails]{
        return latestEvents ?? []
    }
    
    func getUpcomingEvents() -> [MatchDetails]{
        return upcomingEvents ?? []
    }
    
    func loadTeamsDetails() {
        if let latestEvents, let upcomingEvents{
            for item in latestEvents + upcomingEvents {
                if teamsDetails.first(where: { $0.key == item.homeTeamKey }) == nil {
                    teamsDetails.append(TeamDetails(key: item.homeTeamKey, name: item.eventHomeTeam, logo: item.homeTeamLogo, lineup: item.lineups?.homeTeam))
                }
                if teamsDetails.first(where: { $0.key == item.awayTeamKey }) == nil {
                    teamsDetails.append(TeamDetails(key: item.awayTeamKey, name: item.eventAwayTeam, logo: item.awayTeamLogo, lineup: item.lineups?.awayTeam))
                }
            }
        }
        print(teamsDetails)
    }

    func getTeams() -> [TeamDetails]{
        return teamsDetails
    }
}
