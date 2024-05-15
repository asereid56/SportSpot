//
//  LeaguesViewController.swift
//  SportSpot
//
//  Created by Aser Eid on 14/05/2024.
//

import UIKit
import Kingfisher
class LeaguesViewController: UIViewController {
    
    var leaguesViewModel : LeaguesViewModel?
    var sportType: SportType!
    
    @IBOutlet weak var myTableView: UITableView!
    
    var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CustomLeaguesTableViewCell", bundle: nil)
         myTableView.register(nib, forCellReuseIdentifier: "cell")
        
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
            self?.myTableView.reloadData()
            self?.indicator.stopAnimating()
        }
    }
    
    
    func getLeagueViewModel() -> PassSportsType{
        leaguesViewModel = LeaguesViewModel(network: NetworkService())
        return leaguesViewModel!
    }
    
    
}

extension LeaguesViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.leaguesViewModel?.getFootballLeaguesResult().count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell") as! CustomLeaguesTableViewCell
        
        let league = self.leaguesViewModel?.getFootballLeaguesResult()[indexPath.row]
        
        cell.LeagueName.text = league?.leagueName
    
        if let logoURL = league?.leagueLogo {
            cell.leagueImage.kf.setImage(with: logoURL)
        } else {
            
            cell.leagueImage.image = UIImage(named: sportType?.rawValue ?? "leaguePlaceholder")
        }
        cell.leagueImage.layer.cornerRadius = cell.leagueImage.bounds.width / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let league = leaguesViewModel?.getFootballLeaguesResult()[indexPath.row] {
            print(league)
            
            let currentDate = Date()
            let toDay = currentDate.description.split(separator: " ")[0]
            let pastDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate)!.description.split(separator: " ")[0]
            
            
            leaguesViewModel?.loadLeaguesFixtures(from: sportType, for: league.leagueKey, fromDate: String(pastDate), toDate: String(toDay))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
