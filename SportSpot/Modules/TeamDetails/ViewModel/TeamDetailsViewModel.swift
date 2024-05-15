//
//  TeamDetailsViewModel.swift
//  SportSpot
//
//  Created by Aser Eid on 15/05/2024.
//

import Foundation

protocol PassTeamDetails {
    func passTeamToTeamsDetailsScreen(value: TeamDetails)
}

class TeamDetailsViewModel : PassTeamDetails {
    
    
    private var network : Servicing
    private var teamObjDetails : TeamDetails?
    var bindingTeamDetails : (() -> ())?
    
    init(network: Servicing) {
        self.network = network
    }
    
    func passTeamToTeamsDetailsScreen(value: TeamDetails) {
        teamObjDetails = value
    }
    
    func getTheTeam() -> TeamDetails {
        return teamObjDetails!
    }
}
