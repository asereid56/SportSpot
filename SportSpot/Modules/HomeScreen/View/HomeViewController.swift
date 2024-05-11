//
//  ViewController.swift
//  SportSpot
//
//  Created by Aser Eid on 27/04/2024.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var sportsCollectionView: UICollectionView!
    var sportsList : [Sport] = []
    var homeScreenViewModel : HomeScreenViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeScreenViewModel = HomeScreenViewModel()
        
        sportsList = [
        Sport(name: "Football", imgName: "football"),
        Sport(name: "Basketball", imgName: "basketball"),
        Sport(name: "Tennis", imgName: "tennis"),
        Sport(name: "Cricket", imgName: "cricket"),
        ]
     
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.size.width - 16) / 2
            return CGSize(width: width, height: width + 24)
    }
}

extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? HomeCollectionViewCell
        let sport  = sportsList[indexPath.row]
        
        cell?.sportName.text = sport.name
        
        cell?.sportImage.image = UIImage(named: sport.imgName)
            
//        let width = (collectionView.bounds.size.width - 16) / 2
//        cell?.sportImage.frame.size = CGSize(width: width - 8, height: width - 24)
        cell?.layer.cornerRadius = 15
        cell?.layer.masksToBounds = true
        return cell ?? collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leaguesScreen = storyboard?.instantiateViewController(identifier: "leaguesScreen") as! LeaguesTableViewController
        
        let leaguesViewModel = leaguesScreen.getLeagueViewModel()
        
        homeScreenViewModel?.passValueToLeaguesScreen(value: indexPath.row, leaguesViewModel: leaguesViewModel)
        
        print("indexpath: in home view \(indexPath.row)")
        self.navigationController?.pushViewController(leaguesScreen, animated: true)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
    
}

