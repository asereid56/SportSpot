//
//  HomeScreenViewModel.swift
//  SportSpot
//
//  Created by Aser Eid on 11/05/2024.
//

import Foundation

class HomeScreenViewModel{
    
    func passValueToLeaguesScreen(value : Int ,leaguesViewModel : PassSportsType){
        var sportType: SportType = .football
        
        switch value {
            
        case 1:
            sportType = .basketball
        case 2:
            sportType = .tennis
        case 3:
            sportType = .cricket
        default:
            sportType = .football
        }
        
        leaguesViewModel.passSportTypeToleagueScreen(value: sportType)
    }
}
