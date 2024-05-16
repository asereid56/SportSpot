//
//  LeagueDetailsViewModel.swift
//  SportSpot
//
//  Created by Mac on 13/05/2024.
//

import Foundation


protocol PassLeagueDetails {
    func passLeagueIdToleagueDetailsScreen(value: League)
}

class LeagueDetailsViewModel: PassLeagueDetails{
    
    private var network : Servicing
    private var db : LocalDB
    
    var bindDataToViewController : (()->()) = {}

    private var upcomingEvents : [MatchDetails]?
    private var latestEvents : [MatchDetails]?
    private var teamsDetails : [TeamDetails] = []
    
    private var sportType: SportType?
    
    private var league: League?

    init(network: Servicing, db: LocalDB) {
        self.network = network
        self.db = db
    }

    private func loadLeaguesFixtures(from sportType: SportType, for id:Int, fromDate: String, toDate: String, complation:@escaping (Data)->Void ){
        print("call the data")
        network.fetchData(sportType: sportType, methodName: .Fixtures, id: id, fromDate: fromDate, toDate: toDate, firstTeamId: nil, secondTeamId: nil) { response in
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
        let pastDate = Calendar.current.date(byAdding: .year, value: -1, to: Date())!.description.split(separator: " ")[0]
        
        loadLeaguesFixtures(from: sportType ?? .football, for: league?.leagueKey ?? 0 , fromDate: String(pastDate), toDate: String(toDay)){ [weak self] data in
            print("loadLatestEvents")
            
            if let response: Response<MatchDetails> = Utils.convertTo(from: data){
                print("LatestEvents\(data)")
                self?.latestEvents = response.result
                self?.loadTeamsDetails()
                self?.bindDataToViewController()
            }else{
                print("Can't convert the data: \(data)")
            }
        }
    }
    
    func loadUpcomingEvents(){
        
        let toDay = Date().description.split(separator: " ")[0]
        let nextDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())!.description.split(separator: " ")[0]
        
        loadLeaguesFixtures(from: sportType ?? .football, for: league?.leagueKey ?? 0, fromDate: String(toDay), toDate: String(nextDate)){ [weak self] data in
            print("loadUpcomingEvents\(data)")
            if let response: Response<MatchDetails> = Utils.convertTo(from: data){
               
                self?.upcomingEvents = response.result
                self?.loadTeamsDetails()
                self?.bindDataToViewController()
            }
        }
    }
    
    func passTeamToTeamsDetailsScreen(value: Int , to teamDetailsScreen: PassTeamDetails){
        let selectedTeam = getTeams()[value]
        print("selecrted teammmmmm \(selectedTeam)")
        teamDetailsScreen.passTeamToTeamsDetailsScreen(value: selectedTeam.key ?? 1, for: sportType ?? .football)
    }
    
    func passLeagueIdToleagueDetailsScreen(value: League) {
        league = value
        self.sportType = SportType(rawValue: (league?.sportType)!)
    }
    
    func deleteFav(complation: (Bool)->()) {
        let result = db.deleteFromCoreData(league: league!)
        complation(result)
    }
    
    func addToFav(complation: (Bool)->()) {
        let result = db.saveCoreData(league: league!)
        complation(result)
    }
    
    func isFavLeague(complation: (Bool)->()){
        let result = db.searchFromCoreData(league: league!)
        complation(result)
    }
    
    func getSportType() -> SportType {
        return sportType ?? .football
    }
    
    func getLeague() -> League? {
        return league
    }
    
    func getLatestEvents() -> [MatchDetails]{
        return latestEvents ?? []
    }
    
    func getUpcomingEvents() -> [MatchDetails]{
        return upcomingEvents ?? []
    }
    
    func loadTeamsDetails() {
        
        let array = (latestEvents ?? [] ) + (upcomingEvents ?? [])
            for item in array{
                if teamsDetails.first(where: { $0.key == item.homeTeamKey }) == nil {
                    teamsDetails.append(TeamDetails(key: item.homeTeamKey, name: item.eventHomeTeam, logo: item.homeTeamLogo ?? item.eventHomeTeamLogo, lineup: item.lineups?.homeTeam))
                }
                if teamsDetails.first(where: { $0.key == item.awayTeamKey }) == nil {
                    teamsDetails.append(TeamDetails(key: item.awayTeamKey, name: item.eventAwayTeam, logo: item.awayTeamLogo ?? item.eventAwayTeamLogo, lineup: item.lineups?.awayTeam))
                }
        }
        print(teamsDetails)
    }

    func getTeams() -> [TeamDetails]{
        return teamsDetails
    }
}
