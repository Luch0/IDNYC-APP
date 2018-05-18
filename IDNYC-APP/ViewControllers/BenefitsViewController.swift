//
//  BenefitsViewController.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/17/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class BenefitsViewController: UIViewController {

    let benefitsView = BenefitsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(benefitsView)
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Benefits"
    }

}
