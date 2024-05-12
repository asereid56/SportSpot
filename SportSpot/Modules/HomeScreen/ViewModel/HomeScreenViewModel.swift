//
//  HomeScreenViewModel.swift
//  SportSpot
//
//  Created by Aser Eid on 11/05/2024.
//

import Foundation

class HomeScreenViewModel{
    
    func passValueToLeaguesScreen(value : Int ,leaguesViewModel : PassSportsType){
        leaguesViewModel.passValueToleagueScreen(value: value)
    }
}
