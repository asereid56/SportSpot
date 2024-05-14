//
//  LeaguesTableViewController.swift
//  SportSpot
//
//  Created by Aser Eid on 10/05/2024.
//

import UIKit
import Kingfisher

class LeaguesTableViewController: UITableViewController {
    
    var indicator: UIActivityIndicatorView!
    
    var leaguesViewModel : LeaguesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        
        if let sportType = leaguesViewModel?.getSportType(){
            leaguesViewModel?.loadLeagues(from: sportType)
        }
        
        leaguesViewModel?.bindLeaguesToViewController =  { [weak self]  in
            self?.tableView.reloadData()
            self?.indicator.stopAnimating()
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
        let count = self.leaguesViewModel?.getFootballLeaguesResult().count ?? 0
        return count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        
        let league = self.leaguesViewModel?.getFootballLeaguesResult()[indexPath.row]
        
        let leagueName : UILabel = cell.contentView.viewWithTag(1) as! UILabel
        leagueName.text = league?.leagueName
        
        let leagueImage : UIImageView = cell.contentView.viewWithTag(2) as! UIImageView
        if let logoURL = league?.leagueLogo {
            leagueImage.kf.setImage(with: logoURL)
        } else {
            let sportType = leaguesViewModel?.getSportType()
            leagueImage.image = UIImage(named: sportType?.rawValue ?? "leaguePlaceholder")
        }
        
        leagueImage.layer.cornerRadius = leagueImage.bounds.width / 2
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        var details =  (storyboard?.instantiateViewController(withIdentifier: "leagueDetails") as? LeagueDetailsViewController)!
        let leagueDetailsViewModel = details.getLeagueViewModel()

        let league = leaguesViewModel?.getFootballLeaguesResult()[indexPath.row]
        
        leaguesViewModel?.passValueToLeagueDetailsScreen(value: league?.leagueKey ?? 0, leagueDetailsViewModel: leagueDetailsViewModel)
        
        self.present(details, animated: true)
    
    }

}
