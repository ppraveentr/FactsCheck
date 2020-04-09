//
//  FactsService.swift
//  FactsCheck
//
//  Created by Praveen P on 07/04/20.
//  Copyright © 2019 Praveen Prabhakar. All rights reserved.
//

import Foundation

enum FactsError: Error {
    case urlInvalid
    case serviceError
}

//typealias
typealias FactsCompletionHandler = (FactDetails?, FactsError?) -> Void

protocol FactsServiceProtocol {
    var hostUrl: URL? { get }
    var networkManager: NetworkManagerProtocol { get set }

    func fetchFactsList(url: URL?, completion: @escaping FactsCompletionHandler)
}

final class FactsService: FactsServiceProtocol {
    static var shared = FactsService()
    
    var networkManager = NetworkManager.shared
    private(set) var hostUrl = URL(string: kBaseUrl.localized)

     //make the API call to get model
    func fetchFactsList(url: URL? = nil, completion: @escaping FactsCompletionHandler) {
        let serviceURL = url ?? hostUrl
        //unwrap API endpoint
        guard let url = serviceURL else {
            completion(nil, .urlInvalid)
            return
        }
        
        // make api call to fetch details.
        networkManager.makeService(url: url, responseType: FactDetails.self) { result in
            switch result {
                case let .success(model) where model is FactDetails:
                    // onSuccess, remove invlaid details from the list
                    if var details = (model as? FactDetails) {
                        details.trimInvalidFacts()
                        // and update view
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            completion(details, nil)
                        }
                    }
                default:
                    // onError
                    completion(nil, .serviceError)
            }
        }
    }
}
