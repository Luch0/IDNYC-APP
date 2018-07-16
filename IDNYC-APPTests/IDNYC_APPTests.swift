//
//  IDNYC_APPTests.swift
//  IDNYC-APPTests
//
//  Created by Luis Calle on 4/24/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import XCTest
@testable import IDNYC_APP

class IDNYC_APPTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetEnrollmentCenters() {
        let exp = expectation(description: "enrollment centers received")
        let fullUrl = "https://data.cityofnewyork.us/resource/umtz-d4sd.json"
        guard let url = URL(string: fullUrl) else {
            XCTFail("bad URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            } else if let data = data {
                do {
                    let _ = try JSONDecoder().decode([IDNYCCenter].self, from: data)
                    exp.fulfill()
                }
                catch let error {
                    XCTFail(error.localizedDescription)
                }
            }
        }.resume()
        wait(for: [exp], timeout: 10.0)
    }
    
    func testGetDocumentCheckerFromJsonFile() {
        if let pathname = Bundle.main.path(forResource: "DocumentChecker", ofType: "json") {
            guard let data = FileManager.default.contents(atPath: pathname) else {
                XCTFail("Could not load from json file")
                return
            }
            do {
                let decoder = JSONDecoder()
                let _ = try decoder.decode(DocumentCheckerResponse.self, from: data)
            } catch let error {
                XCTFail(error.localizedDescription)
            }
        } else {
            XCTFail("could not get pathname for DocumentChecker.json")
        }
    }
    
    func testGetBenefitsFromJsonFile() {
        if let pathname = Bundle.main.path(forResource: "Benefits", ofType: "json") {
            guard let data = FileManager.default.contents(atPath: pathname) else {
                XCTFail("Could not load from json file")
                return
            }
            do {
                let decoder = JSONDecoder()
                let _ = try decoder.decode(BenefitsResponse.self, from: data)
            } catch let error {
                XCTFail(error.localizedDescription)
            }
        } else {
            XCTFail("could not get pathname for Benefits.json")
        }
    }
    
}
