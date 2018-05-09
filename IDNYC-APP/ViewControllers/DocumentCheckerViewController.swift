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
