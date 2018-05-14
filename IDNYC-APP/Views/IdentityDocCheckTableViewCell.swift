//
//  IdentityDocCheckTableViewCell.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/14/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

protocol IdentityDocCheckTableViewCellDelegate: class {
    func didCheckIdentityDocument(_ tag: Int)
    func didUncheckIdentityDocument(_ tag: Int)
}

class IdentityDocCheckTableViewCell: UITableViewCell {
    
    weak var delegate: IdentityDocCheckTableViewCellDelegate?
    
    private var row: Int?
    private var section: Int?
    
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
    
    lazy var checkBoxButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc private func buttonPressed() {
        UIView.transition(with: checkBoxButton, duration: 0.1, options: .transitionCrossDissolve, animations: {
            if self.checkBoxButton.imageView?.image == #imageLiteral(resourceName: "unchecked") {
                self.checkBoxButton.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            } else {
                self.checkBoxButton.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            }
        }, completion: nil)
        print("Section: \(section!) and row: \(row!)")
    }
    
    lazy var documentLabel: UILabel = {
        let label = UILabel()
        label.text = "Document name"
        label.numberOfLines = 0
        label.font = UIFont(name: "Verdana", size: 18)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: "identity cell")
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
        containerView.addSubview(checkBoxButton)
        checkBoxButton.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            checkBoxButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
            checkBoxButton.heightAnchor.constraint(equalTo: checkBoxButton.widthAnchor),
            checkBoxButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            checkBoxButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            checkBoxButton.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -4)
            ])
    }
    
    private func setupDocumentLabel() {
        containerView.addSubview(documentLabel)
        documentLabel.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            documentLabel.topAnchor.constraint(equalTo: checkBoxButton.topAnchor),
            documentLabel.leadingAnchor.constraint(equalTo: checkBoxButton.trailingAnchor, constant: 4),
            documentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            documentLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
            ])
    }
    
    public func setCellRowAndSection(row: Int, section: Int) {
        self.row = row
        self.section = section
    }

}
