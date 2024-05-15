//
//  HeaderCollectionReusableView.swift
//  SportSpot
//
//  Created by Aser Eid on 15/05/2024.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    static let reuseIdentifier = "MyHeaderView"
      
      let titleLabel: UILabel = {
          let label = UILabel()
          label.textColor = .white
          if let arialFont = UIFont(name: "Baskerville", size: 25) {
                 label.font = arialFont
             }
          return label
      }()
      
      override init(frame: CGRect) {
          super.init(frame: frame)
          
          addSubview(titleLabel)
          titleLabel.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
              titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
              titleLabel.topAnchor.constraint(equalTo: topAnchor),
              titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
          ])
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
      func setTitle(_ title: String) {
          titleLabel.text = title
      }

}
