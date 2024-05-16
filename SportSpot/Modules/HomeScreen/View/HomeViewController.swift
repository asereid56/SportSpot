//
//  ViewController.swift
//  SportSpot
//
//  Created by Aser Eid on 27/04/2024.
//

import UIKit
import Reachability

class HomeViewController: UIViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var sportsCollectionView: UICollectionView!
    var sportsList : [Sport] = []
    var homeScreenViewModel : HomeScreenViewModel?
    var reachability : Reachability!
    func isInternetAvailable() -> Bool {
        return reachability.connection != .unavailable
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reachability = try! Reachability()
        
        let nib = UINib(nibName: "HomeViewCell", bundle: nil)
        sportsCollectionView.register(nib, forCellWithReuseIdentifier: "collectionCell")
        
        homeScreenViewModel = HomeScreenViewModel()
        
        sportsList = [
        Sport(name: "Football", imgName: "homeFootball"),
        Sport(name: "Basketball", imgName: "homeBasketball"),
        Sport(name: "Tennis", imgName: "homeTennis"),
        Sport(name: "Cricket", imgName: "homeCricket"),
        ]
     
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 10) / 2
        let height = width * 1.4
        return CGSize(width: width, height: height)
    }
}

extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! HomeViewCell
        let sport  = sportsList[indexPath.row]
        
        cell.sportName.text = sport.name
        
        cell.sportImage.image = UIImage(named: sport.imgName)
            

        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isInternetAvailable(){
            let leaguesScreen = storyboard?.instantiateViewController(identifier: "leaguesScreen") as! LeaguesViewController
            
            let leaguesViewModel = leaguesScreen.getLeagueViewModel()
            
            homeScreenViewModel?.passValueToLeaguesScreen(value: indexPath.row, leaguesViewModel: leaguesViewModel)
            
            self.navigationController?.pushViewController(leaguesScreen, animated: true)
        }else{
            Utils.showAlert(title: "Connection Failed", message: "Please check your internet connection", view: self, isCancelled: false) {}
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2.5, bottom: 1, right: 2.5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    
}
