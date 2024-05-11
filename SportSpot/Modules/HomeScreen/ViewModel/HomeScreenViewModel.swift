//
//  HomeScreenViewModel.swift
//  SportSpot
//
//  Created by Aser Eid on 11/05/2024.
//

import Foundation

class HomeScreenViewModel{
    
    func passValueToLeaguesScreen(value : Int ,leaguesViewModel : PassSportsType){
        print("in home view model: \(value)")
        leaguesViewModel.passValueToleagueScreen(value: value)
    }
}
