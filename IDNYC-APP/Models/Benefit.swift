//
//  Benefit.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/22/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import Foundation

struct BenefitsResponse: Codable {
    let response: ResponseWrapper
}

struct ResponseWrapper: Codable {
    let benefits: [Benefit]
}

struct Benefit: Codable {
    let type: String
    let description: String
    let places: [String]?
}
