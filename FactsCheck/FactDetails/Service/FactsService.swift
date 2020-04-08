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
        
        // make api call to fetch details.
        NetworkManager.makeService(url: url, responseType: FactDetails.self) { result in
            switch result {
                case let .success(model) where model is FactDetails:
                    // onSuccess, remove invlaid details from the list
                    if var details = (model as? FactDetails) {
                        details.trimInvalidFacts()
                        // and update view
                        completion(details, nil)
                    }
                default:
                    // onError
                    completion(nil, .serviceError)
            }
        }
    }
}
