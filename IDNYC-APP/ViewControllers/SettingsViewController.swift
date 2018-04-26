//
//  SettingsViewController.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 4/24/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let settingsView = SettingsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(settingsView)
        setupNavBar()
    }

    private func setupNavBar() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Verdana", size: UIFont.systemFontSize)! ]
    }
    
}
