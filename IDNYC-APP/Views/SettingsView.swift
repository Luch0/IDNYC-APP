//
//  SettingsView.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 4/24/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    
    lazy var dummyTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        return textField
    }()
    
    lazy var settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "settings cell")
        tableView.separatorStyle = .none
        tableView.bounces = false
        return tableView
    }()
    
//    lazy var languagePickerView: UIPickerView = {
//        let pickerView = UIPickerView()
//        pickerView.backgroundColor = .yellow
//        return pickerView
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
        addSubview(dummyTextField)
        setupSettingsTableView()
        //setupLanguagePickerView()
    }
    
    private func setupSettingsTableView() {
        addSubview(settingsTableView)
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
            ])
    }
    
//    private func setupLanguagePickerView() {
//        addSubview(languagePickerView)
//        languagePickerView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            languagePickerView.topAnchor.constraint(equalTo: self.bottomAnchor),
//            languagePickerView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
//            languagePickerView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.4),
//            languagePickerView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
//            ])
//    }

}
