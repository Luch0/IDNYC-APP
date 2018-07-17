//
//  DocumentCheckerViewController.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/7/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class DocumentCheckerViewController: UIViewController {

    let documentCheckerView = DocumentCheckerView()
    
    var identityChecker = [IdentityWrapper]() {
        didSet {
            documentCheckerView.identityTableView.reloadData()
        }
    }
    
    var residencyChecker = [ResidencyWrapper]() {
        didSet {
            documentCheckerView.residencyTableView.reloadData()
        }
    }
    
    var checkedIdentityIndexPaths = [IndexPath]() {
        didSet {
            dump(checkedIdentityIndexPaths)
        }
    }
    
    var checkedResidencyIndexPaths = [IndexPath]() {
        didSet {
            dump(checkedResidencyIndexPaths)
        }
    }
    
    var documentChecker: DocumentChecker?
    var onlineDocumentChecker: DocumentChecker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(documentCheckerView)
        documentCheckerView.identityTableView.delegate = self
        documentCheckerView.residencyTableView.delegate = self
        documentCheckerView.identityTableView.dataSource = self
        documentCheckerView.residencyTableView.dataSource = self
        documentCheckerView.tableViewsScrollView.delegate = self
//        documentCheckerView.residencyTableView.sectionHeaderHeight = UITableViewAutomaticDimension
//        documentCheckerView.residencyTableView.estimatedSectionHeaderHeight = 40
//        documentCheckerView.identityTableView.rowHeight = UITableViewAutomaticDimension
//        documentCheckerView.identityTableView.estimatedRowHeight = 140
//        documentCheckerView.residencyTableView.rowHeight = UITableViewAutomaticDimension
//        documentCheckerView.residencyTableView.estimatedRowHeight = 140
        setupNavBar()
        setButtonsTargets()
        loadDocumentChecker()
        //loadDocumentCheckerFromOnline()
        highlightIdentityButton()
    }
    
    private func setupNavBar() {
        if LanguageUserDefaultsHelper.manager.getSelectedLanguage() == "Español" {
            navigationItem.title = "Documentos"
            documentCheckerView.identityButton.setTitle("Identidad 0/3", for: .normal)
            documentCheckerView.residencyButton.setTitle("Residecia 0/1", for: .normal)
        } else {
            navigationItem.title = "Document Checker"
            documentCheckerView.identityButton.setTitle("Identity 0/3", for: .normal)
            documentCheckerView.residencyButton.setTitle("Residecy 0/1", for: .normal)
        }
    }
    
    private func setButtonsTargets() {
        documentCheckerView.identityButton.addTarget(self, action:  #selector(clickedIdentity), for: .touchUpInside)
        documentCheckerView.residencyButton.addTarget(self, action:  #selector(clickedResidency), for: .touchUpInside)
    }
    
    @objc private func clickedIdentity() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
            self.documentCheckerView.tableViewsScrollView.contentOffset = CGPoint(x: 0, y: 0)
        }, completion: nil)
        highlightIdentityButton()
    }
    
    @objc private func clickedResidency() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
            self.documentCheckerView.tableViewsScrollView.contentOffset = CGPoint(x: self.documentCheckerView.identityTableView.frame.width, y: 0)
        }, completion: nil)
        highlightResidencyButton()
    }
    
    private func highlightIdentityButton() {
        self.documentCheckerView.identityButton.layer.borderWidth = 1.5
        self.documentCheckerView.residencyButton.layer.borderWidth = 0
    }
    
    private func highlightResidencyButton() {
        self.documentCheckerView.identityButton.layer.borderWidth = 0
        self.documentCheckerView.residencyButton.layer.borderWidth = 1.5
    }
    
    private func loadDocumentChecker() {
        if LanguageUserDefaultsHelper.manager.getSelectedLanguage() == "Español" {
            documentChecker = DocumentCheckerService.manager.loadDocumentChecker(filename: "DocumentChecker_es", type: "json")
        } else {
            documentChecker = DocumentCheckerService.manager.loadDocumentChecker(filename: "DocumentChecker", type: "json")
        }
        guard let documentChecker = documentChecker else {
            print("Error retrieving data")
            return
        }
        identityChecker = documentChecker.identity
        residencyChecker = documentChecker.residency
    }
    
//    private func loadDocumentCheckerFromOnline() {
//        DocumentCheckerService.manager.loadDocumentCheckerFromOnline(completionHandler: {
//            self.onlineDocumentChecker = $0
//            guard let onlineDocumentChecker = self.onlineDocumentChecker else {
//                print("Error retrieving data")
//                return
//            }
//            self.identityChecker = onlineDocumentChecker.identity
//            self.residencyChecker = onlineDocumentChecker.residency
//            //dump(self.identityChecker)
//            //dump(self.residencyChecker)
//        }, errorHandler: { print($0) })
//    }

}

extension DocumentCheckerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Verdana-Bold", size: UIFont.systemFontSize)!
//        header.textLabel?.lineBreakMode = .byWordWrapping
//        header.textLabel?.numberOfLines = 0
//        header.textLabel?.textColor = UIColor.orange
    }
}

extension DocumentCheckerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == documentCheckerView.identityTableView {
            return identityChecker[section].type
        } else if tableView == documentCheckerView.residencyTableView {
            return residencyChecker[section].type
        } else {
            return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //guard let identityChecker = identityChecker, let residencyChecker = residencyChecker else { return 0 }
        if tableView == documentCheckerView.identityTableView {
            return identityChecker.count
        } else if tableView == documentCheckerView.residencyTableView {
            return residencyChecker.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == documentCheckerView.identityTableView {
            return identityChecker[section].documents.count
        } else if tableView == documentCheckerView.residencyTableView {
            return residencyChecker[section].documents.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == documentCheckerView.identityTableView {
            let documentCell = tableView.dequeueReusableCell(withIdentifier: "identity cell", for: indexPath) as! IdentityDocCheckTableViewCell
            documentCell.delegate = self
            documentCell.documentLabel.text = "\(identityChecker[indexPath.section].documents[indexPath.row].document) (\(identityChecker[indexPath.section].documents[indexPath.row].points))"
            if checkedIdentityIndexPaths.contains(indexPath) {
                documentCell.checkBoxButton.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            } else {
                documentCell.checkBoxButton.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            }
            documentCell.setCellRowAndSection(row: indexPath.row, section: indexPath.section)
            documentCell.selectionStyle = .none
            return documentCell
        } else if tableView == documentCheckerView.residencyTableView {
            let documentCell = tableView.dequeueReusableCell(withIdentifier: "residency cell", for: indexPath) as! ResidencyDocCheckTableViewCell
            documentCell.delegate = self
            documentCell.documentLabel.text = "\(residencyChecker[indexPath.section].documents[indexPath.row].document) (\(residencyChecker[indexPath.section].documents[indexPath.row].points))"
            if checkedResidencyIndexPaths.contains(indexPath) {
                documentCell.checkBoxButton.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            } else {
                documentCell.checkBoxButton.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            }
            documentCell.setCellRowAndSection(row: indexPath.row, section: indexPath.section)
            documentCell.selectionStyle = .none
            return documentCell
        } else {
            return UITableViewCell()
        }
    }

}

extension DocumentCheckerViewController: IdentityDocCheckTableViewCellDelegate {
    func didCheckIdentityDocument(_ indexPath: IndexPath) {
        checkedIdentityIndexPaths.append(indexPath)
        let pointsTotal: Int = checkedIdentityIndexPaths.reduce(0){ $0 + identityChecker[$1.section].documents[$1.row].points }
        if pointsTotal >= 3 {
            if LanguageUserDefaultsHelper.manager.getSelectedLanguage() == "Español" {
                documentCheckerView.identityButton.setTitle("Identidad 3/3", for: .normal)
            } else {
                documentCheckerView.identityButton.setTitle("Identity 3/3", for: .normal)
            }
            documentCheckerView.identityButton.backgroundColor = UIColor(displayP3Red: 32/255, green: 168/255, blue: 18/255, alpha: 1.0)
        } else {
            if LanguageUserDefaultsHelper.manager.getSelectedLanguage() == "Español" {
                documentCheckerView.identityButton.setTitle("Identidad \(pointsTotal)/3", for: .normal)
            } else {
                documentCheckerView.identityButton.setTitle("Identity \(pointsTotal)/3", for: .normal)
            }
            documentCheckerView.identityButton.backgroundColor = .red
        }
    }
    
    func didUncheckIdentityDocument(_ indexPath: IndexPath) {
        checkedIdentityIndexPaths = checkedIdentityIndexPaths.filter{ $0 != indexPath }
        let pointsTotal: Int = checkedIdentityIndexPaths.reduce(0){ $0 + identityChecker[$1.section].documents[$1.row].points }
        if pointsTotal >= 3 {
            if LanguageUserDefaultsHelper.manager.getSelectedLanguage() == "Español" {
                documentCheckerView.identityButton.setTitle("Identidad 3/3", for: .normal)
            } else {
                documentCheckerView.identityButton.setTitle("Identity 3/3", for: .normal)
            }
            documentCheckerView.identityButton.backgroundColor = UIColor(displayP3Red: 32/255, green: 168/255, blue: 18/255, alpha: 1.0)
        } else {
            if LanguageUserDefaultsHelper.manager.getSelectedLanguage() == "Español" {
                documentCheckerView.identityButton.setTitle("Identidad \(pointsTotal)/3", for: .normal)
            } else {
                documentCheckerView.identityButton.setTitle("Identity \(pointsTotal)/3", for: .normal)
            }
            documentCheckerView.identityButton.backgroundColor = .red
        }
    }
}

extension DocumentCheckerViewController: ResidencyDocCheckTableViewCellDelegate {
    func didCheckResidencyDocument(_ indexPath: IndexPath) {
        checkedResidencyIndexPaths.append(indexPath)
        let pointsTotal: Int = checkedResidencyIndexPaths.reduce(0){ $0 + residencyChecker[$1.section].documents[$1.row].points }
        if pointsTotal >= 1 {
            if LanguageUserDefaultsHelper.manager.getSelectedLanguage() == "Español" {
                documentCheckerView.residencyButton.setTitle("Residencia 1/1", for: .normal)
            } else {
                documentCheckerView.residencyButton.setTitle("Residency 1/1", for: .normal)
            }
            documentCheckerView.residencyButton.backgroundColor = UIColor(displayP3Red: 32/255, green: 168/255, blue: 18/255, alpha: 1.0)
        } else {
            if LanguageUserDefaultsHelper.manager.getSelectedLanguage() == "Español" {
                documentCheckerView.residencyButton.setTitle("Residencia \(pointsTotal)/1", for: .normal)
            } else {
                documentCheckerView.residencyButton.setTitle("Residency \(pointsTotal)/1", for: .normal)
            }
            documentCheckerView.residencyButton.backgroundColor = .red
        }
    }
    
    func didUncheckResidencyDocument(_ indexPath: IndexPath) {
        checkedResidencyIndexPaths = checkedResidencyIndexPaths.filter{ $0 != indexPath }
        let pointsTotal: Int = checkedResidencyIndexPaths.reduce(0){ $0 + residencyChecker[$1.section].documents[$1.row].points }
        if pointsTotal >= 1 {
            if LanguageUserDefaultsHelper.manager.getSelectedLanguage() == "Español" {
                documentCheckerView.residencyButton.setTitle("Residencia 1/1", for: .normal)
            } else {
                documentCheckerView.residencyButton.setTitle("Residency 1/1", for: .normal)
            }
            documentCheckerView.residencyButton.backgroundColor = UIColor(displayP3Red: 32/255, green: 168/255, blue: 18/255, alpha: 1.0)
        } else {
            if LanguageUserDefaultsHelper.manager.getSelectedLanguage() == "Español" {
                documentCheckerView.residencyButton.setTitle("Residencia \(pointsTotal)/1", for: .normal)
            } else {
                documentCheckerView.residencyButton.setTitle("Residency \(pointsTotal)/1", for: .normal)
            }
            documentCheckerView.residencyButton.backgroundColor = .red
        }
    }

}

extension DocumentCheckerViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == documentCheckerView.tableViewsScrollView {
            let index = Int(round(documentCheckerView.tableViewsScrollView.contentOffset.x/view.frame.width))
            if index == 0 {
                highlightIdentityButton()
            } else {
                highlightResidencyButton()
            }
        }
    }
}
