//
//  TeamDetailsViewController.swift
//  SportSpot
//
//  Created by Aser Eid on 15/05/2024.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    
    var teamDetailsViewModel : TeamDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       let team = teamDetailsViewModel.getTheTeam()

    }
    
    func getTeamDetailsViewModel() -> PassTeamDetails{
        if teamDetailsViewModel == nil {
            teamDetailsViewModel = TeamDetailsViewModel(network: NetworkService())
        }
        return teamDetailsViewModel
    }

}
