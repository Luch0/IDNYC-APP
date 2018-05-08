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
        view.addSubview(whatIsIDNYCView)
        super.viewDidLoad()
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationItem.title = "What is IDNYC?"
    }
    
}
