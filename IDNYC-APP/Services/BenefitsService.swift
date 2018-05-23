//
//  BenefitsService.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/22/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import Foundation

class BenefitsService {
    
    private init() { }
    static let manager = BenefitsService()
    
    func loadBenefits(filename: String, type: String) -> [Benefit]? {
        var benefits: [Benefit]? = nil
        if let pathname = Bundle.main.path(forResource: filename, ofType: type) {
            guard let data = FileManager.default.contents(atPath: pathname) else { return nil }
            do {
                let decoder = JSONDecoder()
                let benefitsResponse = try decoder.decode(BenefitsResponse.self, from: data)
                benefits = benefitsResponse.response.benefits
            } catch {
                print("read json error: \(error)")
            }
        }
        return benefits
    }
     
    func loadBenefitsFromOnline(completionHandler: @escaping ([Benefit]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let fullUrl = "aws gateway endpoint here"
        guard let url = URL(string: fullUrl) else {
            errorHandler(AppError.badURL(str: fullUrl))
            return
        }
        let urlRequest = URLRequest(url: url)
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let decoder = JSONDecoder()
                let benefitsResponse = try decoder.decode(BenefitsResponse.self, from: data)
                completionHandler(benefitsResponse.response.benefits)
            }
            catch {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        NetworkService.manager.performDataTask(with: urlRequest, completionHandler: completion, errorHandler: errorHandler)
    }
}
