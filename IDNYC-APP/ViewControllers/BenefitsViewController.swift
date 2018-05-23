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
    var benefits: [Benefit]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(benefitsView)
        benefitsView.benefitsTableView.delegate = self
        benefitsView.benefitsTableView.dataSource = self
        setupNavBar()
        loadBenefits()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Benefits"
    }
    
    private func loadBenefits() {
        benefits = BenefitsService.manager.loadBenefits(filename: "Benefits", type: "json")
        guard benefits != nil else {
            print("Error retrieving data")
            return
        }
    }

}

extension BenefitsViewController: UITableViewDelegate {
    
}

extension BenefitsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return benefits!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let benefitCell = tableView.dequeueReusableCell(withIdentifier: "benefit cell", for: indexPath) as! BenefitTableViewCell
        let benefit = benefits![indexPath.row]
        benefitCell.typeLabel.text = benefit.type
        benefitCell.descriptionLabel.text = benefit.description
        return benefitCell
    }
    
    
}
