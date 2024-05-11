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
    var url : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let result = leaguesViewModel?.resultToSearch
        switch result {
            
        case 0:
            url = Utils.footballLeaguesUrl
        case 1:
            url = Utils.basketBallLeaguesUrl
        case 2:
            url = Utils.tennisLeaguesUrl
        case 3:
            url = Utils.cricketLeaguesUrl
        default:
            url = Utils.footballLeaguesUrl
        }
        
        leaguesViewModel?.loadFootballLeagues(from: url!)
        
        leaguesViewModel?.bindLeaguesToViewController =  { [weak self]  in
            self?.leagues = self?.leaguesViewModel?.getFootballLeaguesResult()
            self?.tableView.reloadData()
        }
        
    }
    

    
    func getLeagueViewModel() -> LeaguesViewModel{
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
                     
                     leagueImage.image = UIImage(named: "leaguePlaceholder")
                 }
     
     return cell
     }
     
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
