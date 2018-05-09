//
//  DocumentCheckerView.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/7/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class DocumentCheckerView: UIView {
    
    lazy var identityContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    lazy var identityTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "document cell")
        return tableView
    }()
    
    lazy var residencyContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    lazy var residencyTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "document cell")
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
        setupIdentityContainer()
        setupIdentityTableView()
        setupResidencyLabel()
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
    
    private func setupIdentityContainer() {
        addSubview(identityContainer)
        identityContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            identityContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            identityContainer.bottomAnchor.constraint(equalTo: identityLabel.topAnchor),
            identityContainer.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            identityContainer.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            ])
    }
    
    private func setupIdentityTableView() {
        identityContainer.addSubview(identityTableView)
        identityTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            identityTableView.topAnchor.constraint(equalTo: identityContainer.topAnchor),
            identityTableView.bottomAnchor.constraint(equalTo: identityContainer.bottomAnchor),
            identityTableView.leadingAnchor.constraint(equalTo: identityContainer.leadingAnchor),
            identityTableView.trailingAnchor.constraint(equalTo: identityContainer.trailingAnchor)
            ])
    }
    
    private func setupResidencyContainer() {
        addSubview(residencyContainer)
        residencyContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            residencyContainer.topAnchor.constraint(equalTo: identityContainer.topAnchor),
            residencyContainer.bottomAnchor.constraint(equalTo: identityContainer.bottomAnchor),
            residencyContainer.widthAnchor.constraint(equalTo: identityContainer.widthAnchor),
            residencyContainer.leadingAnchor.constraint(equalTo: identityContainer.trailingAnchor),
            residencyContainer.centerYAnchor.constraint(equalTo: identityContainer.centerYAnchor)
            ])
    }
    
    private func setupResidencyTableView() {
        residencyContainer.addSubview(residencyTableView)
        residencyTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            residencyTableView.topAnchor.constraint(equalTo: residencyContainer.topAnchor),
            residencyTableView.bottomAnchor.constraint(equalTo: residencyContainer.bottomAnchor),
            residencyTableView.leadingAnchor.constraint(equalTo: residencyContainer.leadingAnchor),
            residencyTableView.trailingAnchor.constraint(equalTo: residencyContainer.trailingAnchor)
            ])
    }
    
}
