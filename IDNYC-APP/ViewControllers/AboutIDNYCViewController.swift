//
//  AboutIDNYCViewController.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/17/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class AboutIDNYCViewController: UIViewController {

    let aboutIDNYCView = AboutIDNYCView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(aboutIDNYCView)
        setupNavBar()
    }
    
    private func setupNavBar() {
        if LanguageUserDefaultsHelper.manager.getSelectedLanguage() == "Español" {
            navigationItem.title = "Sobre IDNYC"
            aboutIDNYCView.setSpanish()
        } else {
            navigationItem.title = "About IDNYC"
        }
    }

}
