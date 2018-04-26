//
//  BoroughCollectionViewCell.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 4/24/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class BoroughCollectionViewCell: UICollectionViewCell {
    
    lazy var boroughNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Verdana", size: 20)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = UIColor(displayP3Red: 214/256, green: 71/256, blue: 41/256, alpha: 1.0)
        self.layer.cornerRadius = 8
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupBoroughLabel()
    }
    
    private func setupBoroughLabel() {
        addSubview(boroughNameLabel)
        boroughNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let labelTopAnchor = boroughNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5)
        let labelLeadingAnchor = boroughNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5)
        let labelTrailingAnchor = boroughNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5)
        let labelBottomAnchor = boroughNameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5)
        labelTopAnchor.priority = UILayoutPriority(999)
        labelLeadingAnchor.priority = UILayoutPriority(999)
        labelTrailingAnchor.priority = UILayoutPriority(999)
        labelBottomAnchor.priority = UILayoutPriority(999)
        NSLayoutConstraint.activate([labelTopAnchor, labelLeadingAnchor, labelTrailingAnchor,labelBottomAnchor])
    }
    
}
