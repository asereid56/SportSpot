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
    @IBOutlet weak var playerOneNum: UILabel!
    @IBOutlet weak var playerOneName: UILabel!
    @IBOutlet weak var playerTwoNum: UILabel!
    @IBOutlet weak var playerTwoName: UILabel!
    @IBOutlet weak var playerThreeNum: UILabel!
    @IBOutlet weak var playerThreeName: UILabel!
    @IBOutlet weak var playerFourNum: UILabel!
    @IBOutlet weak var playerFourName: UILabel!
    @IBOutlet weak var playerFiveNum: UILabel!
    @IBOutlet weak var playerFiveName: UILabel!
    @IBOutlet weak var playerSixNum: UILabel!
    @IBOutlet weak var playerSixName: UILabel!
    @IBOutlet weak var playerSevenNum: UILabel!
    @IBOutlet weak var playerSevenName: UILabel!
    @IBOutlet weak var playerEightNum: UILabel!
    @IBOutlet weak var playerEightName: UILabel!
    @IBOutlet weak var playerNineNum: UILabel!
    @IBOutlet weak var playerNineName: UILabel!
    @IBOutlet weak var playerTenNum: UILabel!
    @IBOutlet weak var playerTenName: UILabel!
    @IBOutlet weak var playerTwelveNum: UILabel!
    @IBOutlet weak var playerTwelveName: UILabel!
    @IBOutlet weak var coachName: UILabel!
    
    @IBOutlet weak var substituationTableVIew: UITableView!
    
    var teamDetailsViewModel : TeamDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let team = teamDetailsViewModel.getTheTeam()
        
        teamImage.kf.setImage(with: team.logo)
        teamName.text = team.name
        
        team.lineup?.startingLineups?.forEach{ player in
            switch player.playerPosition {
            case 1 :
                self.playerOneNum.text = String(player.playerNumber!)
                self.playerOneName.text = player.player
            case 2 :
                self.playerTwoNum.text = String(player.playerNumber!)
                self.playerTwoName.text = player.player
            case 3 :
                self.playerThreeNum.text = String(player.playerNumber!)
                self.playerThreeName.text = player.player
            case 4 :
                self.playerFourNum.text = String(player.playerNumber!)
                self.playerFourName.text = player.player
            case 5 :
                self.playerFiveNum.text = String(player.playerNumber!)
                self.playerFiveName.text = player.player
            case 6 :
                self.playerSixNum.text = String(player.playerNumber!)
                self.playerSixName.text = player.player
            case 7 :
                self.playerSevenNum.text = String(player.playerNumber!)
                self.playerSevenName.text = player.player
            case 8 :
                self.playerEightNum.text = String(player.playerNumber!)
                self.playerEightName.text = player.player
            case 9 :
                self.playerNineNum.text = String(player.playerNumber!)
                self.playerNineName.text = player.player
            case 10 :
                self.playerTenNum.text = String(player.playerNumber!)
                self.playerTenName.text = player.player
            case 11 :
                self.playerTwelveNum.text = String(player.playerNumber!)
                self.playerTwelveName.text = player.player
            default:
                break
            
            }
        }
        
        if let coach = team.lineup?.coaches?.first?.coache {
            coachName.text = coach
        } else {
           
            coachName.text = "No Coach"
            
            let alert = UIAlertController(title: "Alert", message: "No data for this team", preferredStyle: .alert)
             let ok = UIAlertAction(title: "ok", style: .default) { action in
                 self.dismiss(animated: true)
             }
             alert.addAction(ok)
            self.present(alert, animated: true)
        }
        

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if teamDetailsViewModel.getTheTeam().lineup?.substitutes?.count == 0 {
            tableView.isHidden = true
            return 0
        }else{
            tableView.isHidden = false
            return teamDetailsViewModel.getTheTeam().lineup?.substitutes?.count ?? 0
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let currentPlayer = teamDetailsViewModel.getTheTeam().lineup?.substitutes?[indexPath.row]
        
        let playerNum : UILabel = cell.contentView.viewWithTag(1) as! UILabel
        
        if let playerNumber = currentPlayer?.playerNumber {
            playerNum.text = String(playerNumber)
        } else {
            playerNum.text = ""
        }
        let playerName : UILabel = cell.contentView.viewWithTag(2) as! UILabel
        if let playerNam = currentPlayer?.player {
            
            playerName.text = playerNam
        } else {
            playerName.text = ""
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
