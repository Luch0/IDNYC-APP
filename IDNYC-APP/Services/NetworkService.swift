//
//  NetworkService.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 4/24/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import Foundation

enum AppError: Error {
    case noData
    case couldNotParseJSON(rawError: Error)
    case badURL(str: String)
    case urlError(rawError: URLError)
    case otherError(rawError: Error)
}

class NetworkService {
    
    private init() {
        urlSession.configuration.requestCachePolicy = .returnCacheDataElseLoad
    }
    static let manager = NetworkService()
    
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    func performDataTask(with request: URLRequest, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        if let response = URLCache.shared.cachedResponse(for: request) {
            completionHandler(response.data)
            return
        }
        self.urlSession.dataTask(with: request){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {errorHandler(AppError.noData); return}
                if let error = error {
                    errorHandler(error)
                }
                completionHandler(data)
            }
            }.resume()
    }
    
}
