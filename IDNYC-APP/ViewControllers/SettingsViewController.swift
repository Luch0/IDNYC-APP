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
    
    let options:[String] = ["Change Language","About IDNYC","Feedback", "Visit Official Site"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.settingsTableView.delegate = self
        settingsView.settingsTableView.dataSource = self
        view.addSubview(settingsView)
        setupNavBar()
    }

    private func setupNavBar() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Verdana-Bold", size: UIFont.systemFontSize)! ]
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settings cell", for: indexPath)
        cell.textLabel?.font = UIFont(name: "Verdana", size: 18)!
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
}
