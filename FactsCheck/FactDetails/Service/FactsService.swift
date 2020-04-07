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

enum FactsService {
    
    static let hostUrl = URL(string: BaseUrl.localized)
    
     //make the API call to get model
    static func fetchFactsList(completion: @escaping FactsCompletionHandler) {
        //unwrap API endpoint
        guard let url = hostUrl else {
            completion(nil, .urlInvalid)
            return
        }
        
        NetworkManager.makeService(url: url, responseType: FactDetails.self) { result in
            switch result {
                case let .success(model):
                     completion(model as? FactDetails, nil)
                case .failure(_):
                    completion(nil, .serviceError)
            }
        }
    }
}
