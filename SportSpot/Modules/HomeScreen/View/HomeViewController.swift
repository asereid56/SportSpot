//
//  ViewController.swift
//  SportSpot
//
//  Created by Aser Eid on 27/04/2024.
//

import UIKit

class HomeViewController: UIViewController  , UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var sportsCollectionView: UICollectionView!
    var sportsList : [Sport] = []
    var homeScreenViewModel : HomeScreenViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sportsList = [
        Sport(name: "Football", imgName: "football"),
        Sport(name: "Basketball", imgName: "basketball"),
        Sport(name: "Tennis", imgName: "tennis"),
        Sport(name: "Cricket", imgName: "cricket"),
        ]
     
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.width - 20) / 2
            let height = width + 25
            return CGSize(width: width, height: height)
    }
}

extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sportsCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        let sport  = sportsList[indexPath.row]
        
        let sportName : UILabel = cell.contentView.viewWithTag(1) as! UILabel
        sportName.text = sport.name
        
        let sportImage : UIImageView = cell.contentView.viewWithTag(2) as! UIImageView
        sportImage.image = UIImage(named: sport.imgName)
        
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let leaguesScreen = storyboard?.instantiateViewController(identifier: "leaguesScreen") as! LeaguesTableViewController
        
        let leaguesViewModel = leaguesScreen.getLeagueViewModel()
        
        homeScreenViewModel?.passValueToLeaguesScreen(value: indexPath.row, leaguesViewModel: leaguesViewModel)
        
        self.navigationController?.pushViewController(leaguesScreen, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 7, bottom: 1, right: 7)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
}

