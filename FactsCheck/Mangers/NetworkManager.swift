//
//  NetworkManager.swift
//  FactsCheck
//
//  Created by Praveen P on 08/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case dataNotAvaialble
    case invalidEncoding
}

typealias CompletionHandler = (Result<Codable, NetworkError>) -> Void

final class NetworkManager {
    
    //create a session and dataTask on that session to get data/response/error
    private static let session: URLSession = URLSession.shared
    private static var imageCache = NSCache<NSString, UIImage>()

    /**
     Download Image from async in background
     - parameter url: url to make api request
     - parameter responseType: Codable.Type to format data to requested Resposne model
     - parameter completion: return's Result on completion of request in Main thread
     */
    static func makeService<T: Codable>(url: URL, responseType: T.Type, completion: CompletionHandler?) {
        
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
        
        // start request
        dataTask.resume()
    }
    
    /**
     Download Image from async in background
     - parameter url: Image's url from which need to download
     - parameter contentMode: ImageView's content mode, defalut to 'scaleAspectFit'
     */
    static func downloadedImage(url: URL, allowCache: Bool = true, _ comletionHandler: ImageViewComletionHandler? = nil) {
        let localCache = allowCache ? imageCache : nil
        
        // Cache image based on URL
        let cacheKey = url.absoluteString as NSString
        if let image = localCache?.object(forKey: cacheKey) {
            // Update view's image in main thread
            comletionHandler?(image)
            return
        }
        
        // Setup URLSession
        let sesstion = session.dataTask(with: url) { data, response, error in
             // validate for proper data and imageType
            guard let data: Data = data,
                error == nil,
                let mimeType = response?.mimeType,
                mimeType.hasPrefix("image"),
                let image = UIImage(data: data) else {
                    // remove cached image
                    localCache?.removeObject(forKey: cacheKey)
                    comletionHandler?(nil)
                    return
            }
            
            // Cache image localy
            localCache?.setObject(image, forKey: cacheKey)
            
            // After Image download compeltion
            comletionHandler?(image)
        }
        sesstion.resume()
    }
}

private extension NetworkManager {
    static func formatedData(_ jsonData: Data?) throws -> Data {
        // validate if proper json avaialble
        guard let unwrappedData = jsonData else {
            throw NetworkError.dataNotAvaialble
        }
        // Encoding based on response' mimeType
        guard let string = String(data: unwrappedData, encoding: .isoLatin1) else {
            throw NetworkError.invalidEncoding
        }
        // convert data to 'utf8' for JSON decoding
        guard let properData = string.data(using: .utf8, allowLossyConversion: true) else {
            throw NetworkError.invalidEncoding
        }
        return properData
    }
    
    // Decode data based on generic response.Type
    static func encodedData<T: Codable>(_ jsonData: Data) throws -> T {
        let model = try JSONDecoder().decode(T.self, from: jsonData)
        return model
    }
}
