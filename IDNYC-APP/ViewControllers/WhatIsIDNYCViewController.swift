//
//  WhatISIDNYCViewController.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/4/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class WhatIsIDNYCViewController: UIViewController {

    let whatIsIDNYCView = WhatIsIDNYCView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(whatIsIDNYCView)
        NotificationCenter.default.addObserver(self, selector: #selector(setToEnglish(notification:)), name: .english, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setToSpanish(notfication:)), name: .spanish, object: nil)
        setupNavBar()
    }
    
    private func setupNavBar() {
        if LanguageUserDefaultsHelper.manager.getSelectedLanguage() == "Español" {
            navigationItem.title = "¿Que es IDNYC?"
            whatIsIDNYCView.setSpanish()
        } else {
            navigationItem.title = "What is IDNYC?"
        }
    }
    
    // MARK: NotificationCenter
    @objc func setToEnglish(notification: NSNotification) {
        whatIsIDNYCView.setEnglish()
        navigationItem.title = "What is IDNYC?"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
    }
    @objc func setToSpanish(notfication: NSNotification) {
        whatIsIDNYCView.setSpanish()
        navigationItem.title = "¿Que es IDNYC?"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Inicio", style: .plain, target: nil, action: nil)
    }
    
}
