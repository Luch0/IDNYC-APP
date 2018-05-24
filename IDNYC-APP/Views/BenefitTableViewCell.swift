//
//  BenefitTableViewCell.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/22/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

//class ExpandingTableViewCellContent {
//    var type: String?
//    var description: String?
//    var expanded: Bool
//    
//    init(type: String, description: String) {
//        self.type = type
//        self.description = description
//        self.expanded = false
//    }
//}

class BenefitTableViewCell: UITableViewCell {

    lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.shadowOpacity = 1
        container.layer.shadowOffset = CGSize(width: 0, height: 1)
        container.layer.shadowRadius = 1
        container.layer.shadowColor = UIColor(displayP3Red: 214/256, green: 71/256, blue: 41/256, alpha: 1.0).cgColor
        //d64729
        return container
    }()
    
    lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "down"), for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc private func buttonPressed() {
    }
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type"
        label.numberOfLines = 0
        label.font = UIFont(name: "Verdana-Bold", size: 23)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.numberOfLines = 0
        label.font = UIFont(name: "Verdana", size: 18)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: "benefit cell")
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupContainerView()
        setupArrowButton()
        setupTypeLabel()
        setupDescriptionLabel()
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
            ])
    }
    
    private func setupArrowButton() {
        containerView.addSubview(arrowButton)
        arrowButton.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            arrowButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.08),
            arrowButton.heightAnchor.constraint(equalTo: arrowButton.widthAnchor),
            arrowButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            arrowButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -6)
            ])
    }
    
    private func setupTypeLabel() {
        containerView.addSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6),
            typeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 6),
            typeLabel.trailingAnchor.constraint(equalTo: arrowButton.leadingAnchor, constant: -4),
            ])
    }
    
    private func setupDescriptionLabel() {
        containerView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 6),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -6),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
            ])
    }

}
