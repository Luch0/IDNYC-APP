//
//  DocumentCheckerService.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 5/7/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import Foundation

class DocumentCheckerService {
    
    
    private init() { }
    static let manager = DocumentCheckerService()
    
    func loadDocumentChecker(filename: String, type: String) -> DocumentChecker? {
        var documentChecker: DocumentChecker? = nil
        if let pathname = Bundle.main.path(forResource: filename, ofType: type) {
            guard let data = FileManager.default.contents(atPath: pathname) else { return nil }
            do {
                let decoder = JSONDecoder()
                let documentCheckerResponse = try decoder.decode(DocumentCheckerResponse.self, from: data)
                documentChecker = documentCheckerResponse.response
            } catch {
                print("read json error: \(error.localizedDescription)")
            }
        }
        return documentChecker
    }
    
    func loadDocumentCheckerFromOnline(completionHandler: @escaping (DocumentChecker) -> Void, errorHandler: @escaping (Error) -> Void) {
        let fullUrl = "https://fikj4h1av8.execute-api.us-east-2.amazonaws.com/prod/documentchecker"
        guard let url = URL(string: fullUrl) else {
            errorHandler(AppError.badURL(str: fullUrl))
            return
        }
        let urlRequest = URLRequest(url: url)
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let decoder = JSONDecoder()
                let documentCheckerResponse = try decoder.decode(DocumentCheckerResponse.self, from: data)
                completionHandler(documentCheckerResponse.response)
            }
            catch {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        NetworkService.manager.performDataTask(with: urlRequest, completionHandler: completion, errorHandler: errorHandler)
    }
}
