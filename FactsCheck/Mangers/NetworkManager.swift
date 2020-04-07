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
    
    static func makeService<T: Codable>(url: URL, responseType: T.Type, completion: @escaping CompletionHandler) {
        //create a session and dataTask on that session to get data/response/error
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { (data, response, networkError) in
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
