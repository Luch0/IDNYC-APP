//
//  DocumentCheckerTableViewCell.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/10/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

// TODO: delegation for button press, fill check and points calcualtion

class DocumentCheckerTableViewCell: UITableViewCell {
    
    lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.shadowOpacity = 1
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.shadowRadius = 1
        container.layer.shadowColor = UIColor(displayP3Red: 214/256, green: 71/256, blue: 41/256, alpha: 1.0).cgColor
        //d64729
        return container
    }()

    lazy var checkBoxImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "unchecked")
        return imageView
    }()
    
    lazy var documentLabel: UILabel = {
        let label = UILabel()
        label.text = "Document name"
        label.numberOfLines = 0
        label.font = UIFont(name: "Verdana", size: 18)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: "document cell")
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
        setupCheckBox()
        setupDocumentLabel()
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
            ])
    }
    
    private func setupCheckBox() {
        containerView.addSubview(checkBoxImageView)
        checkBoxImageView.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            checkBoxImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
            checkBoxImageView.heightAnchor.constraint(equalTo: checkBoxImageView.widthAnchor),
            checkBoxImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            checkBoxImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            checkBoxImageView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -2)
            ])
    }
    
    private func setupDocumentLabel() {
        containerView.addSubview(documentLabel)
        documentLabel.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            documentLabel.topAnchor.constraint(equalTo: checkBoxImageView.topAnchor),
            documentLabel.leadingAnchor.constraint(equalTo: checkBoxImageView.trailingAnchor, constant: 4),
            documentLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -4),
            documentLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            ])
    }
    
    

}
