//
//  DocumentCheckerView.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/7/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class DocumentCheckerView: UIView {
    
    // TODO: add tableviews for each check
    
    lazy var identityContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    lazy var residencyContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
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
        setupResidencyLabel()
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
    
}
