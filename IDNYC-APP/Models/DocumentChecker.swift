//
//  DocumentChecker.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/7/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import Foundation

struct DocumentCheckerResponse: Codable {
    let response: DocumentChecker
}

struct DocumentChecker: Codable {
    let identity: [IdentityWrapper]
    let residency: [ResidencyWrapper]
}

struct IdentityWrapper: Codable {
    let type: String
    let documents: [DocumentsWrapper]
}

struct ResidencyWrapper: Codable {
    let type: String
    let documents: [DocumentsWrapper]
}

struct DocumentsWrapper: Codable {
    let document: String
    let points: Int
}
