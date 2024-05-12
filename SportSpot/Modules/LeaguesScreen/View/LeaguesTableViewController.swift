//
//  LeaguesTableViewController.swift
//  SportSpot
//
//  Created by Aser Eid on 10/05/2024.
//

import UIKit
import Kingfisher
class LeaguesTableViewController: UITableViewController {
    var leaguesViewModel : LeaguesViewModel?
    var leagues : [League]?
    var sportType: SportType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let result = leaguesViewModel?.resultToSearch
        switch result {
            
        case 1:
            sportType = .basketball
        case 2:
            sportType = .tennis
        case 3:
            sportType = .cricket
        default:
            sportType = .football

        }
        
        leaguesViewModel?.loadLeagues(from: sportType ?? .football)
        
        leaguesViewModel?.bindLeaguesToViewController =  { [weak self]  in
            self?.leagues = self?.leaguesViewModel?.getFootballLeaguesResult()
            self?.tableView.reloadData()
        }
        
    }
    
    func getLeagueViewModel() -> PassSportsType{
        leaguesViewModel = LeaguesViewModel(network: NetworkService())
        return leaguesViewModel!
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return leagues?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
         
         let league = leagues?[indexPath.row]
         
         let leagueName : UILabel = cell.contentView.viewWithTag(1) as! UILabel
         leagueName.text = league?.leagueName
         
         let leagueImage : UIImageView = cell.contentView.viewWithTag(2) as! UIImageView
         if let logoURL = league?.leagueLogo {
                     leagueImage.kf.setImage(with: logoURL)
                 } else {
                     
                     leagueImage.image = UIImage(named: sportType?.rawValue ?? "leaguePlaceholder")
                 }
         leagueImage.layer.cornerRadius = leagueImage.bounds.width / 2
     
     return cell
     }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var details =  (storyboard?.instantiateViewController(withIdentifier: "leagueDetails") as? LeagueDetailsViewController)!
        
        self.present(details, animated: true)
    }
}
