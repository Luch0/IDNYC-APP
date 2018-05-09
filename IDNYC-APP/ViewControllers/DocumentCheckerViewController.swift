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
    var identityChecker: [IdentityWrapper]?
    var residencyChecker: [ResidencyWrapper]?
    var documentChecker: DocumentChecker?
    var onlineDocumentChecker: DocumentChecker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(documentCheckerView)
        documentCheckerView.identityTableView.delegate = self
        documentCheckerView.residencyTableView.delegate = self
        documentCheckerView.identityTableView.dataSource = self
        documentCheckerView.residencyTableView.dataSource = self
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
            dump(self.identityChecker)
            dump(self.residencyChecker)
        }, errorHandler: { print($0) })
    }

}

extension DocumentCheckerViewController: UITableViewDelegate {
    
}

extension DocumentCheckerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == documentCheckerView.identityTableView {
            return identityChecker![section].type
        } else if tableView == documentCheckerView.residencyTableView {
            return residencyChecker![section].type
        } else {
            return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == documentCheckerView.identityTableView {
            return identityChecker!.count
        } else if tableView == documentCheckerView.residencyTableView {
            return residencyChecker!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == documentCheckerView.identityTableView {
            return identityChecker![section].documents.count
        } else if tableView == documentCheckerView.residencyTableView {
            return residencyChecker![section].documents.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let documentCell = tableView.dequeueReusableCell(withIdentifier: "document cell", for: indexPath)
        if tableView == documentCheckerView.identityTableView {
            documentCell.textLabel?.text = identityChecker![indexPath.section].documents[indexPath.row].document
            return documentCell
        } else if tableView == documentCheckerView.residencyTableView {
            documentCell.textLabel?.text = residencyChecker![indexPath.section].documents[indexPath.row].document
            return documentCell
        } else {
            return UITableViewCell()
        }
    }
    
    
}
