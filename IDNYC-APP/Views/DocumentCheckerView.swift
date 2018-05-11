//
//  DocumentCheckerView.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/7/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class DocumentCheckerView: UIView {
    
    lazy var tableViewsScrollView: UIView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        return scrollView
    }()
    
    lazy var tableViewsContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var identityTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "document cell")
        tableView.bounces = false
        return tableView
    }()
    
    lazy var residencyTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "document cell")
        tableView.bounces = false
        return tableView
    }()
    
    lazy var identityLabel: UILabel = {
        let label = UILabel()
        label.text = "Identity"
        label.font = UIFont(name: "Verdana", size: 18)
        label.textColor = .white
        label.backgroundColor = .green
        label.textAlignment = .center
        return label
    }()
    
    lazy var residencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Residency"
        label.font = UIFont(name: "Verdana", size: 18)
        label.textColor = .white
        label.backgroundColor = .red
        label.textAlignment = .center
        return label
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
        setupIdentityLabel()
        setupResidencyLabel()
        setupTableViewsScrollView()
        setupTableViewsContainer()
        setupIdentityTableView()
        setupResidencyTableView()
    }
    
    private func setupIdentityLabel() {
        addSubview(identityLabel)
        identityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            identityLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            identityLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            identityLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            identityLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor,multiplier: 0.1)
            ])
    }
    
    private func setupResidencyLabel() {
        addSubview(residencyLabel)
        residencyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            residencyLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            residencyLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            residencyLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            residencyLabel.heightAnchor.constraint(equalTo: identityLabel.heightAnchor)
            ])
    }
    
    private func setupTableViewsScrollView() {
        addSubview(tableViewsScrollView)
        tableViewsScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableViewsScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableViewsScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableViewsScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableViewsScrollView.bottomAnchor.constraint(equalTo: identityLabel.topAnchor)
            ])
    }
    
    private func setupTableViewsContainer() {
        tableViewsScrollView.addSubview(tableViewsContainer)
        tableViewsContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableViewsContainer.topAnchor.constraint(equalTo: tableViewsScrollView.topAnchor),
            tableViewsContainer.bottomAnchor.constraint(equalTo: tableViewsScrollView.bottomAnchor),
            tableViewsContainer.trailingAnchor.constraint(equalTo: tableViewsScrollView.trailingAnchor),
            tableViewsContainer.leadingAnchor.constraint(equalTo: tableViewsScrollView.leadingAnchor),
            tableViewsContainer.centerYAnchor.constraint(equalTo: tableViewsScrollView.centerYAnchor)
        ])
    }
    
    private func setupIdentityTableView() {
        tableViewsContainer.addSubview(identityTableView)
        identityTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            identityTableView.heightAnchor.constraint(equalTo: tableViewsContainer.heightAnchor),
            identityTableView.widthAnchor.constraint(equalTo: self.widthAnchor),
            identityTableView.leadingAnchor.constraint(equalTo: tableViewsContainer.leadingAnchor),
            identityTableView.centerYAnchor.constraint(equalTo: tableViewsContainer.centerYAnchor)
            ])
    }
    
    private func setupResidencyTableView() {
        tableViewsContainer.addSubview(residencyTableView)
        residencyTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            residencyTableView.heightAnchor.constraint(equalTo: identityTableView.heightAnchor),
            residencyTableView.widthAnchor.constraint(equalTo: identityTableView.widthAnchor),
            residencyTableView.leadingAnchor.constraint(equalTo: identityTableView.trailingAnchor),
            residencyTableView.centerYAnchor.constraint(equalTo: identityTableView.centerYAnchor),
            residencyTableView.trailingAnchor.constraint(equalTo: tableViewsContainer.trailingAnchor)
            ])
    }
    
}
