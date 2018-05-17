//
//  DocumentCheckerView.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/7/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class DocumentCheckerView: UIView {
    
    lazy var tableViewsScrollView: UIScrollView = {
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
        tableView.register(IdentityDocCheckTableViewCell.self, forCellReuseIdentifier: "identity cell")
        tableView.bounces = false
        return tableView
    }()
    
    lazy var residencyTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ResidencyDocCheckTableViewCell.self, forCellReuseIdentifier: "residency cell")
        tableView.bounces = false
        return tableView
    }()
    
    lazy var identityButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Verdana", size: 18)
        button.setTitle("Identity 0/3", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    lazy var residencyButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Verdana", size: 18)
        button.setTitle("Residency 0/1", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
//    lazy var identityLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Identity 0/3"
//        label.font = UIFont(name: "Verdana", size: 18)
//        label.textColor = .white
//        label.backgroundColor = .red
//        label.textAlignment = .center
//        label.layer.borderWidth = 1
//        label.layer.borderColor = UIColor.white.cgColor
//        return label
//    }()
//
//    lazy var residencyLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Residency 0/1"
//        label.font = UIFont(name: "Verdana", size: 18)
//        label.textColor = .white
//        label.backgroundColor = .red
//        label.textAlignment = .center
//        label.layer.borderWidth = 1
//        label.layer.borderColor = UIColor.white.cgColor
//        return label
//    }()
    
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
        setupIdentityButton()
        setupResidencyButton()
        setupTableViewsScrollView()
        setupTableViewsContainer()
        setupIdentityTableView()
        setupResidencyTableView()
    }
    
    private func setupIdentityButton() {
        addSubview(identityButton)
        identityButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            identityButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            identityButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            identityButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            identityButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor,multiplier: 0.1)
            ])
    }
    
    private func setupResidencyButton() {
        addSubview(residencyButton)
        residencyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            residencyButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            residencyButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            residencyButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            residencyButton.heightAnchor.constraint(equalTo: identityButton.heightAnchor)
            ])
    }
    
    private func setupTableViewsScrollView() {
        addSubview(tableViewsScrollView)
        tableViewsScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableViewsScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableViewsScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableViewsScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableViewsScrollView.bottomAnchor.constraint(equalTo: identityButton.topAnchor)
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
