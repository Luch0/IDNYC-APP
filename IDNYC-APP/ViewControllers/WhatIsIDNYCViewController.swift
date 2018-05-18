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
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationItem.title = "What is IDNYC?"
    }
    
}
