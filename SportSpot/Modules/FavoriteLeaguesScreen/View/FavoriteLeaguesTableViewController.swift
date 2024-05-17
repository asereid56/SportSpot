//
//  FavoriteLeaguesTableViewController.swift
//  SportSpot
//
//  Created by Aser Eid on 10/05/2024.
//

import UIKit
import Reachability
class FavoriteLeaguesViewController: UIViewController {
    @IBOutlet weak var noDataImage: UIImageView!
    @IBOutlet weak var myFavoriteLeaguesTableView: UITableView!
    
    var favoriteViewModel : FavoriteViewModel?
    var football : [League] = []
    var basketball : [League] = []
    var tennis : [League] = []
    var cricket : [League] = []
    
    var reachability : Reachability!
    func isInternetAvailable() -> Bool {
        return reachability.connection != .unavailable
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reachability = try! Reachability()
        
        let nib = UINib(nibName: "CustomLeaguesTableViewCell", bundle: nil)
        myFavoriteLeaguesTableView.register(nib, forCellReuseIdentifier: "cell")
        
        favoriteViewModel = FavoriteViewModel(db: DataBase(persistentContainer: (UIApplication.shared.delegate as! AppDelegate).persistentContainer))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteViewModel?.loadLeaguesFromDataBase()
        updateLeaguesForEachArray ()
        myFavoriteLeaguesTableView.reloadData()
    }
    
    func updateLeaguesForEachArray (){
        football = favoriteViewModel?.getLeagues().filter{ $0.sportType == SportType.football.rawValue} ?? []
        basketball = favoriteViewModel?.getLeagues().filter{ $0.sportType == SportType.basketball.rawValue} ?? []
        tennis = favoriteViewModel?.getLeagues().filter{ $0.sportType == SportType.tennis.rawValue} ?? []
        cricket = favoriteViewModel?.getLeagues().filter{ $0.sportType == SportType.cricket.rawValue} ?? []
    }
    
}

extension FavoriteLeaguesViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = football.count + basketball.count + tennis.count + cricket.count
        noDataImage.isHidden = (count > 0)
        print(count)
        switch section{
        case 0:
            return football.count
        case 1:
            return basketball.count
        case 2:
            return tennis.count
        case 3:
            return cricket.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        updateLeaguesForEachArray ()
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0 :
            return "Football Leagues:"
        case 1 :
            return "Basketball Leagues:"
        case 2 :
            return "Tennis Leagues:"
        case 3 :
            return "Cricket Leagues:"
        default:
            break
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 35))
        headerView.backgroundColor = .background
        
        let headerLabel = UILabel(frame: CGRect(x: 15, y: -8, width: tableView.frame.width, height: 35))
        
        headerLabel.font = UIFont(name: "Baskerville", size: 25)
        headerLabel.textColor = UIColor.white
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        headerView.addSubview(headerLabel)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myFavoriteLeaguesTableView.dequeueReusableCell(withIdentifier: "cell") as! CustomLeaguesTableViewCell
        var league : League? = nil
        
        switch indexPath.section {
        case 0:
            league = football[indexPath.row]
        case 1:
            league = basketball[indexPath.row]
        case 2:
            league = tennis[indexPath.row]
        case 3:
            league = cricket[indexPath.row]
        default:
            break
            
        }
        
        if let logoURL = league?.leagueLogo {
            cell.leagueImage.kf.setImage(with: logoURL ,placeholder:   UIImage(named: league?.sportType ?? "cup"))
        } else {
            cell.leagueImage.image = UIImage(named: league?.sportType ?? "cup")
        }
        
        cell.LeagueName.text = league?.leagueName
        cell.leagueImage.layer.cornerRadius = cell.leagueImage.bounds.size.height / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)  {
        
        if editingStyle == .delete {
            Utils.showAlert(title: "Delete League", message: "Do you want to delete this league?", view: self , isCancelled : true) {
                var league : League?
                switch indexPath.section {
                case 0:
                    league = self.football[indexPath.row]
                case 1:
                    league = self.basketball[indexPath.row]
                case 2:
                    league = self.tennis[indexPath.row]
                case 3:
                    league = self.cricket[indexPath.row]
                default:
                    break
                }
                if let isDeleted = self.favoriteViewModel?.deleteLeague(for: league) , isDeleted{
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isInternetAvailable(){
            
            let details =  (storyboard?.instantiateViewController(withIdentifier: "leagueDetails") as? LeagueDetailsViewController)!
            let leagueDetailsViewModel = details.getLeagueViewModel()
            
            var league : League?
            switch indexPath.section {
            case 0:
                league = self.football[indexPath.row]
            case 1:
                league = self.basketball[indexPath.row]
            case 2:
                league = self.tennis[indexPath.row]
            case 3:
                league = self.cricket[indexPath.row]
            default:
                break
            }
            
            favoriteViewModel?.passValueToLeagueDetailsScreen(league: league!, leagueDetailsViewModel: leagueDetailsViewModel)
            
            self.present(details, animated: true)
        }else{
            Utils.showAlert(title: "Connection Failed", message: "Please check your internet connection", view: self, isCancelled: false) {}
            
        }
    }
    
}


