//
//  IDNYCCenter.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 4/24/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import Foundation

struct IDNYCCenter: Codable {
    let address1: String
    let address2: String?
    let city: String
    let hours: String?
    let id: String
    let location_1: LocationWrapper?
    let name: String
    let type: String
    let zip: String
}

struct LocationWrapper: Codable {
    let type: String
    let coordinates: [Double]
}
