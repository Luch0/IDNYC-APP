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
    var isExpandedCell = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(benefitsView)
        benefitsView.benefitsTableView.delegate = self
        benefitsView.benefitsTableView.dataSource = self
        benefitsView.benefitsTableView.estimatedRowHeight = 50
        benefitsView.benefitsTableView.rowHeight = UITableViewAutomaticDimension
        NotificationCenter.default.addObserver(self, selector: #selector(setToEnglish(notification:)), name: .english, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setToSpanish(notfication:)), name: .spanish, object: nil)
        setupNavBar()
        loadBenefits()
    }
    
    private func setupNavBar() {
        if LanguageUserDefaultsHelper.manager.getSelectedLanguage() == "Español" {
            navigationItem.title = "Beneficios"
        } else {
            navigationItem.title = "Benefits"
        }
    }
    
    private func loadBenefits() {
        if LanguageUserDefaultsHelper.manager.getSelectedLanguage() == "Español" {
            benefits = BenefitsService.manager.loadBenefits(filename: "Benefits_es", type: "json")
        } else {
            benefits = BenefitsService.manager.loadBenefits(filename: "Benefits", type: "json")
        }
        isExpandedCell = Array(repeating: false, count: benefits!.count)
        guard benefits != nil else {
            print("Error retrieving data")
            return
        }
    }
    
    // MARK: NotificationCenter
    @objc func setToEnglish(notification: NSNotification) {
        loadBenefits()
        benefitsView.benefitsTableView.reloadData()
        navigationItem.title = "Benefits"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
    }
    @objc func setToSpanish(notfication: NSNotification) {
        loadBenefits()
        benefitsView.benefitsTableView.reloadData()
        navigationItem.title = "Beneficios"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Inicio", style: .plain, target: nil, action: nil)
    }

}

extension BenefitsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isExpandedCell[indexPath.row] = !isExpandedCell[indexPath.row]
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension BenefitsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return benefits!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let benefitCell = tableView.dequeueReusableCell(withIdentifier: "benefit cell", for: indexPath) as! BenefitTableViewCell
        benefitCell.selectionStyle = .none
        let benefit = benefits![indexPath.row]
        benefitCell.typeLabel.text = benefit.type
        // check if cell is expanded or not
        //benefitCell.descriptionLabel.text = isExpandedCell[indexPath.row] ? benefit.description : ""
        if(isExpandedCell[indexPath.row]) {
            benefitCell.arrowButton.setImage(#imageLiteral(resourceName: "up"), for: .normal)
            if let places = benefit.places {
                let restOfDescription = places.reduce("\n"){ $0 + "\n● " + $1 }
                let fullDescription = "\(benefit.description)\(restOfDescription)"
                benefitCell.descriptionLabel.text = fullDescription
            } else {
                benefitCell.descriptionLabel.text = benefit.description
            }
        } else {
            benefitCell.arrowButton.setImage(#imageLiteral(resourceName: "down"), for: .normal)
            benefitCell.descriptionLabel.text = ""
        }
        return benefitCell
    }
    
    
}
