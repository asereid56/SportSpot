//
//  TeamsViewCell.swift
//  SportSpot
//
//  Created by Aser Eid on 12/05/2024.
//

import UIKit

class TeamsViewCell: UICollectionViewCell {
    @IBOutlet weak var teamImage: UIImageView!
    func setup(){
        teamImage.layoutIfNeeded()
        teamImage.layer.cornerRadius = teamImage.frame.height/2
    }
}
