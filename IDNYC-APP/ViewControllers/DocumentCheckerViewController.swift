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
//        documentCheckerView.residencyTableView.sectionHeaderHeight = UITableViewAutomaticDimension
//        documentCheckerView.residencyTableView.estimatedSectionHeaderHeight = 40
//        documentCheckerView.identityTableView.rowHeight = UITableViewAutomaticDimension
//        documentCheckerView.identityTableView.estimatedRowHeight = 140
//        documentCheckerView.residencyTableView.rowHeight = UITableViewAutomaticDimension
//        documentCheckerView.residencyTableView.estimatedRowHeight = 140
        setupNavBar()
        //loadDocumentChecker()
        loadDocumentCheckerFromOnline()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Document Checker"
    }
    
//    private func loadDocumentChecker() {
//        documentChecker = DocumentCheckerService.manager.loadDocumentChecker(filename: "DocumentChecker", type: "json")
//        guard let documentChecker = documentChecker else {
//            print("Error retrieving data")
//            return
//        }
//        identityChecker = documentChecker.identity
//        residencyChecker = documentChecker.residency
//    }
    
    private func loadDocumentCheckerFromOnline() {
        DocumentCheckerService.manager.loadDocumentCheckerFromOnline(completionHandler: {
            self.onlineDocumentChecker = $0
            guard let onlineDocumentChecker = self.onlineDocumentChecker else {
                print("Error retrieving data")
                return
            }
            self.identityChecker = onlineDocumentChecker.identity
            self.residencyChecker = onlineDocumentChecker.residency
            //dump(self.identityChecker)
            //dump(self.residencyChecker)
        }, errorHandler: { print($0) })
    }

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
            documentCheckerView.identityLabel.text = "Identity 3/3"
            documentCheckerView.identityLabel.backgroundColor = UIColor(displayP3Red: 32/255, green: 168/255, blue: 18/255, alpha: 1.0)
        } else {
            documentCheckerView.identityLabel.text = "Identity \(pointsTotal)/3"
            documentCheckerView.identityLabel.backgroundColor = .red
        }
    }
    
    func didUncheckIdentityDocument(_ indexPath: IndexPath) {
        checkedIdentityIndexPaths = checkedIdentityIndexPaths.filter{ $0 != indexPath }
        let pointsTotal: Int = checkedIdentityIndexPaths.reduce(0){ $0 + identityChecker[$1.section].documents[$1.row].points }
        if pointsTotal >= 3 {
            documentCheckerView.identityLabel.text = "Identity 3/3"
            documentCheckerView.identityLabel.backgroundColor = UIColor(displayP3Red: 32/255, green: 168/255, blue: 18/255, alpha: 1.0)
        } else {
            documentCheckerView.identityLabel.text = "Identity \(pointsTotal)/3"
            documentCheckerView.identityLabel.backgroundColor = .red
        }
    }
}

extension DocumentCheckerViewController: ResidencyDocCheckTableViewCellDelegate {
    func didCheckResidencyDocument(_ indexPath: IndexPath) {
        checkedResidencyIndexPaths.append(indexPath)
        let pointsTotal: Int = checkedResidencyIndexPaths.reduce(0){ $0 + residencyChecker[$1.section].documents[$1.row].points }
        if pointsTotal >= 1 {
            documentCheckerView.residencyLabel.text = "Residency 1/1"
            documentCheckerView.residencyLabel.backgroundColor = UIColor(displayP3Red: 32/255, green: 168/255, blue: 18/255, alpha: 1.0)
        } else {
            documentCheckerView.residencyLabel.text = "Residency \(pointsTotal)/1"
            documentCheckerView.residencyLabel.backgroundColor = .red
        }
    }
    
    func didUncheckResidencyDocument(_ indexPath: IndexPath) {
        checkedResidencyIndexPaths = checkedResidencyIndexPaths.filter{ $0 != indexPath }
        let pointsTotal: Int = checkedResidencyIndexPaths.reduce(0){ $0 + residencyChecker[$1.section].documents[$1.row].points }
        if pointsTotal >= 1 {
            documentCheckerView.residencyLabel.text = "Residency 1/1"
            documentCheckerView.residencyLabel.backgroundColor = UIColor(displayP3Red: 32/255, green: 168/255, blue: 18/255, alpha: 1.0)
        } else {
            documentCheckerView.residencyLabel.text = "Residency \(pointsTotal)/1"
            documentCheckerView.residencyLabel.backgroundColor = .red
        }
    }

}
