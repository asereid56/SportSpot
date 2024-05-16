//
//  LeaguesViewController.swift
//  SportSpot
//
//  Created by Aser Eid on 14/05/2024.
//

import UIKit
import Kingfisher
import Reachability
class LeaguesViewController: UIViewController {
    
    @IBOutlet weak var noDataImage: UIImageView!
    
    @IBOutlet weak var myTableView: UITableView!
    
    var indicator: UIActivityIndicatorView!
    var leaguesViewModel : LeaguesViewModel?
    
    var reachability : Reachability!
    func isInternetAvailable() -> Bool {
        return reachability.connection != .unavailable
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        reachability = try! Reachability()
       
        navigationController?.navigationBar.tintColor = UIColor.systemYellow
        let nib = UINib(nibName: "CustomLeaguesTableViewCell", bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: "cell")
        
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
        noDataImage.isHidden = (count > 0)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell") as! CustomLeaguesTableViewCell
        
        let league = self.leaguesViewModel?.getFootballLeaguesResult()[indexPath.row]
        
        cell.LeagueName.text = league?.leagueName
        let sportType = leaguesViewModel?.getSportType()
        
        if let logoURL = league?.leagueLogo {
            cell.leagueImage.kf.setImage(with: logoURL ,placeholder:   UIImage(named: sportType?.rawValue ?? "cup"))
        } else {
            cell.leagueImage.image = UIImage(named: sportType?.rawValue ?? "cup")
        }
        cell.leagueImage.layer.cornerRadius = cell.leagueImage.bounds.width / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if isInternetAvailable(){
            let details =  (storyboard?.instantiateViewController(withIdentifier: "leagueDetails") as? LeagueDetailsViewController)!
            let leagueDetailsViewModel = details.getLeagueViewModel()

            leaguesViewModel?.passValueToLeagueDetailsScreen(at: indexPath.row, leagueDetailsViewModel: leagueDetailsViewModel)
            
            self.present(details, animated: true)
        }else{
            Utils.showAlert(title: "Connection Failed", message: "Please check your internet connection", view: self, isCancelled: false) {}
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
