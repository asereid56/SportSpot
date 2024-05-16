//
//  FavoriteViewModel.swift
//  SportSpot
//
//  Created by Aser Eid on 16/05/2024.
//

import Foundation
class FavoriteViewModel {
    private var db : LocalDB
    private var leagues : [League]?
    
    init(db: LocalDB) {
        self.db = db
    }
    
    func loadLeaguesFromDataBase(){
        leagues = db.fetchCoreData()
    }
    
    func getLeagues() -> [League]{
        return leagues ?? []
    }
    
    func deleteLeague (for league : League?) -> Bool{
        if let league{
            if db.deleteFromCoreData(league: league){
                loadLeaguesFromDataBase()
                return true
            }
        }
        return false
    }
    
    func passValueToLeagueDetailsScreen(at : Int ,leagueDetailsViewModel : PassLeagueDetails){
        let league = leagues![at]
        
        leagueDetailsViewModel.passLeagueIdToleagueDetailsScreen(value: league)
    }
}
