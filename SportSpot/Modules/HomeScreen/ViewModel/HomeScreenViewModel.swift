//
//  HomeScreenViewModel.swift
//  SportSpot
//
//  Created by Aser Eid on 11/05/2024.
//

import Foundation

class HomeScreenViewModel{
    var leaguesViewModel : LeaguesViewModel?
    
    func passValueToLeaguesScreen(value : Int ,leaguesViewModel : LeaguesViewModel){
        leaguesViewModel.passValueToleagueScreen(value: value)
    }
}
