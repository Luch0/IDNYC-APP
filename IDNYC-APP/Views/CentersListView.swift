//
//  CentersListView.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 4/26/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class CentersListView: UIView {
    
    lazy var centersTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(EnrollmentCenterTableViewCell.self, forCellReuseIdentifier: "center cell")
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
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
        setupCentersTableView()
    }
    
    private func setupCentersTableView() {
        addSubview(centersTableView)
        centersTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centersTableView.topAnchor.constraint(equalTo: topAnchor),
            centersTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            centersTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            centersTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
