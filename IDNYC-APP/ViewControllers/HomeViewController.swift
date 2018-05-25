//
//  HomeViewController.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 4/24/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let homeView = HomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.tintColor =  UIColor(displayP3Red: 214/256, green: 71/256, blue: 41/256, alpha: 1.0)
        view.addSubview(homeView)
        setupNavBar()
        setupButtonActions()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Verdana-Bold", size: UIFont.systemFontSize)! ]
    }
    
    private func setupButtonActions() {
        homeView.whatIsIDNYCButton.addTarget(self, action: #selector(whatIsIDNYCTapped), for: .touchUpInside)
        homeView.documentCheckerButton.addTarget(self, action: #selector(documentCheckerTapped), for: .touchUpInside)
        homeView.benefitsButton.addTarget(self, action: #selector(benefitsTapped), for: .touchUpInside)
    }
    
    @objc private func whatIsIDNYCTapped() {
        let whatIsIDNYCViewController = WhatIsIDNYCViewController()
        navigationController?.pushViewController(whatIsIDNYCViewController, animated: true)
    }
    
    @objc private func documentCheckerTapped() {
        let documenttCheckerViewController = DocumentCheckerViewController()
        navigationController?.pushViewController(documenttCheckerViewController, animated: true)
    }
    
    @objc private func benefitsTapped() {
        let benefitsViewController = BenefitsViewController()
        navigationController?.pushViewController(benefitsViewController, animated: true)
    }


}
