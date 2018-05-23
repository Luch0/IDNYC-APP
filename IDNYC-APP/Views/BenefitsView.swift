//
//  BenefitsView.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/17/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class BenefitsView: UIView {

    lazy var benefitsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BenefitTableViewCell.self, forCellReuseIdentifier: "benefit cell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
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
        setupBenefitsTableView()
    }
    
    private func setupBenefitsTableView() {
        addSubview(benefitsTableView)
        benefitsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            benefitsTableView.topAnchor.constraint(equalTo: topAnchor),
            benefitsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            benefitsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            benefitsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
}

