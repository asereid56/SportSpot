//
//  TeamDetailsViewController.swift
//  SportSpot
//
//  Created by Aser Eid on 15/05/2024.
//

import UIKit


class TeamDetailsViewController: UIViewController {
    
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var playerTableVIew: UITableView!
    @IBOutlet weak var noDataImage: UIImageView!
    
    var teamDetailsViewModel : TeamDetailsViewModel!
    var players: [Player] = []
    var injured: [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        let nib = UINib(nibName: "CustomTeamCell", bundle: nil)
        playerTableVIew.register(nib, forCellReuseIdentifier: "customTeamCell")

        teamDetailsViewModel.bindingTeamDetails = { [weak self] in
            DispatchQueue.main.async {
                let team = self?.teamDetailsViewModel.getTheTeam()
                self?.teamImage.kf.setImage(with: URL(string: team?.teamLogo ?? ""),placeholder: UIImage(named: "cup"))
                self?.teamImage.layer.cornerRadius = 8
                self?.coachName.text = team?.coaches?.first?.coachName ?? "No Coach"
                self?.teamName.text = team?.teamName
                if let name = team?.teamName{
                    self?.noDataImage.isHidden = true
                }
            
                self?.players = self?.teamDetailsViewModel.getTheTeam()?.players?.filter{ $0.playerInjured == "No"} ?? []
                self?.injured = self?.teamDetailsViewModel.getTheTeam()?.players?.filter{ $0.playerInjured == "Yes"} ?? []
                self?.playerTableVIew.reloadData()
            }
        }
  
        teamDetailsViewModel.loadTeamData()
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func getTeamDetailsViewModel() -> PassTeamDetails{
        if teamDetailsViewModel == nil {
            teamDetailsViewModel = TeamDetailsViewModel(network: NetworkService())
        }
        return teamDetailsViewModel
    }

}

extension TeamDetailsViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Team Players"
        case 1:
            return "Injured Players"
        default:
            break
        }
        return nil
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 35))
        headerView.backgroundColor = .background
    
        let headerLabel = UILabel(frame: CGRect(x: 15, y: -8, width: tableView.frame.width, height: 35))
        
        headerLabel.font = UIFont(name: "Baskerville", size: 20)
        headerLabel.textColor = UIColor.white
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

        headerView.addSubview(headerLabel)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        switch section{
        case 0:
            return players.count
        case 1:
            return injured.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "customTeamCell", for: indexPath) as! CustomTeamCell
        
        var currentPlayer: Player?
   
        
        switch indexPath.section{
        case 0 :
            currentPlayer = players[indexPath.row]
        
        case 1 :
            currentPlayer = injured[indexPath.row]
            
        default:
            break
        }
        
        cell.playerImage.kf.setImage(with: URL(string :currentPlayer?.playerImage ?? "") , placeholder: UIImage(named: "player"))
        cell.playerImage.layer.cornerRadius = cell.playerImage.bounds.height / 2
        cell.playerNum.text = currentPlayer?.playerNumber
        cell.playerPosition.text = currentPlayer?.playerType
        cell.playerInjured.isHidden = (currentPlayer?.playerInjured == "No")
        cell.playerInjured.layer.cornerRadius = cell.playerInjured.bounds.height / 2
        cell.playerName.text = currentPlayer?.playerName
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
}
