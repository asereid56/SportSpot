//
//  LeagueDetailsViewController.swift
//  SportSpot
//
//  Created by Aser Eid on 12/05/2024.
//

import UIKit
import Kingfisher

class LeagueDetailsViewController: UIViewController {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var leagueDetailsName: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var leagueDetailsViewModel: LeagueDetailsViewModel?
    var isDataReady = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewCompositionalLayout{
            index , environment in
            if index == 0 {
                return self.drawTopSection()
            }else if index == 1 {
                return self.drawMiddleSection()
            }else if index == 2{
                return self.drawBottomSection()
            }
            return nil
        }
        myCollectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.reuseIdentifier)
        
        myCollectionView.setCollectionViewLayout(layout, animated: true)
        
        _ = getLeagueViewModel()
        
        leagueDetailsViewModel?.bindLatestEventsToViewController = { [weak self] in
            DispatchQueue.main.async {
                print("bindLatestEventsToViewController")
                if let nameLeague = self?.leagueDetailsViewModel?.getLatestEvents().first?.leagueName {
                    self?.leagueDetailsName.text = nameLeague
                }else{
                    self?.leagueDetailsName.text = self?.leagueDetailsViewModel?.getUpcomingEvents().first?.leagueName
                }
                
                self?.myCollectionView.reloadData()
            }
        }
        leagueDetailsViewModel?.bindUpcomingEventsToViewController = { [weak self] in
            DispatchQueue.main.async {
                print("bindUpcomingEventsToViewController")
                self?.myCollectionView.reloadData()
            }
        }
        
        print("before call view model")
        leagueDetailsViewModel?.loadUpcomingEvents()
        leagueDetailsViewModel?.loadLatestEvents()
        
        
    }
    
    @IBAction func favBtn(_ sender: Any) {
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func getLeagueViewModel() -> PassLeagueDetails{
        if let leagueDetailsViewModel{
            return leagueDetailsViewModel
        }else{
            leagueDetailsViewModel = LeagueDetailsViewModel(network: NetworkService())
            return leagueDetailsViewModel!
        }
    }
    
    func drawTopSection() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.3)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 10, leading: 10, bottom: 0, trailing: 10)
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        return section
    }
    
    func drawMiddleSection() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.13)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 10, leading: 16, bottom: 0, trailing: 16)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        
        return section
    }
    
    func drawBottomSection() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(90), heightDimension: .absolute(90)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 10, leading: 10, bottom: 0, trailing: 10)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        return section
    }
}


extension LeagueDetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return leagueDetailsViewModel?.getUpcomingEvents().count ?? 0
        case 1:
            return leagueDetailsViewModel?.getLatestEvents().count ?? 0
        case 2:
            return leagueDetailsViewModel?.getTeams().count ?? 0
        default:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let teamDetailsScreen =  (storyboard?.instantiateViewController(withIdentifier: "TeamDetails") as? TeamDetailsViewController)!
            
            let teamDetailsViewModel = teamDetailsScreen.getTeamDetailsViewModel()
            
            leagueDetailsViewModel?.passTeamToTeamsDetailsScreen(value: indexPath.row , to: teamDetailsViewModel)
            
            self.present(teamDetailsScreen, animated: true)
            print("Cell selected in section 2")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "topCell", for: indexPath) as! UpcomingViewCell
            
            let matchDetails = leagueDetailsViewModel?.getUpcomingEvents()[indexPath.row]
            
            if let teamOneImage = matchDetails?.homeTeamLogo{
                cell.teamOneImage.kf.setImage(with: teamOneImage)
            }
            if let teamTwoImage = matchDetails?.awayTeamLogo{
                cell.teamTwoImage.kf.setImage(with: teamTwoImage)
            }
            cell.teamOneName.text = matchDetails?.eventHomeTeam
            cell.teamTwoName.text = matchDetails?.eventAwayTeam
            cell.timeDetails.text = matchDetails?.eventTime
            cell.dateDetails.text = matchDetails?.eventDate
            cell.leagueDetails.text = matchDetails?.stageName
            
            cell.layer.cornerRadius = 16
            return cell
        case 1:
            let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "MiddleCell", for: indexPath) as! LatestResultViewCell
            
            let matchDetails = leagueDetailsViewModel?.getLatestEvents()[indexPath.row]
            
            if let teamOneImage = matchDetails?.homeTeamLogo{
                cell.teamOneImage.kf.setImage(with: teamOneImage)
            }
            if let teamTwoImage = matchDetails?.awayTeamLogo{
                cell.teamTwoImage.kf.setImage(with: teamTwoImage)
            }
            
            cell.dateDetails.text = matchDetails?.eventDate
            cell.timeDetails.text = matchDetails?.eventTime
            cell.teamOneName.text = matchDetails?.eventHomeTeam
            cell.teamTwoName.text = matchDetails?.eventAwayTeam
            cell.teamOneScore.text = matchDetails?.eventFinalResult
            
            cell.layer.cornerRadius = 16
            return cell
        case 2:
            let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "bottomCell", for: indexPath) as! TeamsViewCell
            
            let teamDetails = leagueDetailsViewModel?.getTeams()[indexPath.row]
            
            cell.teamImage.kf.setImage(with: teamDetails?.logo)
            
            cell.setup()
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else{
            return UICollectionReusableView()
        }
        
        let headerView : HeaderCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.reuseIdentifier, for: indexPath) as! HeaderCollectionReusableView
        
        switch indexPath.section {
        case 0:
            if leagueDetailsViewModel?.getUpcomingEvents().count == 0{
                headerView.isHidden = true
            }else{
                headerView.isHidden = false
                headerView.setTitle("Upcoming Events")
            }
            
        case 1:
            if leagueDetailsViewModel?.getLatestEvents().count == 0{
                headerView.isHidden = true
            }else{
                headerView.isHidden = false
                headerView.setTitle("Latest Events")
            }
            
        case 2:
            if leagueDetailsViewModel?.getTeams().count == 0{
                headerView.isHidden = true
                backgroundImage.isHidden = false
           
            }else{
                headerView.isHidden = false
                backgroundImage.isHidden = true
                headerView.setTitle("Teams")
            }
            
        default:
            break
        }
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
    
}


