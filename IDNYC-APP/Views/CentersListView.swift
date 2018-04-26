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
        tableView.register(EnrollmentCenterTableViewCell.self, forCellReuseIdentifier: "EventCell")
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
    }

}
