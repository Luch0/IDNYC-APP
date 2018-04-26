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
        view.addSubview(homeView)
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Verdana", size: UIFont.systemFontSize)! ]
    }


}
