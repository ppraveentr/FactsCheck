//
//  NetworkManager.swift
//  FactsCheck
//
//  Created by Praveen P on 08/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case dataNotAvaialble
    case invalidEncoding
}

typealias CompletionHandler = (Result<Codable, NetworkError>) -> Void

final class NetworkManager {
    
    //create a session and dataTask on that session to get data/response/error
    private static let session: URLSession = URLSession.shared

    static func makeService<T: Codable>(url: URL, responseType: T.Type, completion: CompletionHandler?) {
        
        // stubbing data for testing
        if let mockData = self.mockData(responseType: responseType) {
            DispatchQueue.main.async {
                completion?(.success(mockData))
            }
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data, response, networkError) in
            // parsing not requied if completion is provided
            guard let completion = completion else { return }
            
            do {
                //unwrap returned data
                let properData = try formatedData(data)
                // parse unwrappedData to Codable Model as requested
                let model: T? = try encodedData(properData)
                
                //Run on the main queue as completion handler handles UI display and we don't want to block any UI code.
                DispatchQueue.main.async {
                    completion(.success(model))
                }
            }
            catch {
                // on any failure to parse data, return error.
                //Run on the main queue as completion handler handles UI display and we don't want to block any UI code.
                DispatchQueue.main.async {
                    completion(.failure(.dataNotAvaialble))
                }
            }
        }
        
        //Inital call
        dataTask.resume()
    }
}

private extension NetworkManager {
    static func formatedData(_ jsonData: Data?) throws -> Data {
        guard let unwrappedData = jsonData else {
            throw NetworkError.dataNotAvaialble
        }
        guard let string = String(data: unwrappedData, encoding: .isoLatin1) else {
            throw NetworkError.invalidEncoding
        }
        guard let properData = string.data(using: .utf8, allowLossyConversion: true) else {
            throw NetworkError.invalidEncoding
        }
        return properData
    }
    
    static func encodedData<T: Codable>(_ jsonData: Data) throws -> T {
        let model = try JSONDecoder().decode(T.self, from: jsonData)
        return model
    }
}

extension NetworkManager {
    static func mockData<T: Codable>(responseType: T.Type) -> T? {
        if let path = Bundle.main.path(forResource: "Mockfacts", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                // parse unwrappedData to Codable Model as requested
                if let properData = try? formatedData(data) {
                    return try? encodedData(properData)
                }
            }
        }
        return nil
    }
}
