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
    var sportType: SportType!
    
    var indicator: UIActivityIndicatorView!
    
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
        
        indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        
        leaguesViewModel?.loadLeagues(from: sportType)

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
                     
                     leagueImage.image = UIImage(named: sportType?.rawValue ?? "leaguePlaceholder")
                 }
         leagueImage.layer.cornerRadius = leagueImage.bounds.width / 2
     
     return cell
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let league = leaguesViewModel?.getFootballLeaguesResult()[indexPath.row] {
            print(league)
            
            let currentDate = Date()
            let toDay = currentDate.description.split(separator: " ")[0]
            let pastDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate)!.description.split(separator: " ")[0]

            
            leaguesViewModel?.loadLeaguesFixtures(from: sportType, for: league.leagueKey, fromDate: String(pastDate), toDate: String(toDay))
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var details =  (storyboard?.instantiateViewController(withIdentifier: "leagueDetails") as? LeagueDetailsViewController)!
        
        self.present(details, animated: true)
    }
}
