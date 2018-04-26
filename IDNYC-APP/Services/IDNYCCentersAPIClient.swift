//
//  IDNYCCentersAPIClient.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 4/24/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import Foundation

struct IDNYCCentersAPIClient {
    
    private init() {}
    static let manager = IDNYCCentersAPIClient()
    
    func getEnrollmetCenters(with zipCode: String, completionHandler: @escaping ([IDNYCCenter]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let fullUrl = "https://data.cityofnewyork.us/resource/umtz-d4sd.json"
        guard let url = URL(string: fullUrl) else {
            errorHandler(AppError.badURL(str: fullUrl))
            return
        }
        let urlRequest = URLRequest(url: url)
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let centers = try JSONDecoder().decode([IDNYCCenter].self, from: data)
                completionHandler(centers)
            }
            catch {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        NetworkService.manager.performDataTask(with: urlRequest, completionHandler: completion, errorHandler: errorHandler)
    }
    
}
