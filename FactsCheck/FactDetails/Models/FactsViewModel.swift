//
//  FactsViewModel.swift
//  FactsCheck
//
//  Created by Praveen P on 08/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

import UIKit

final class FactsViewModel {
    
    //factDetails hold's the data from the backend
    var facts: FactDetails? {
        didSet {
            print(self.facts ?? "")
        }
    }
}

extension FactsViewModel {
    //API call to fetch the Facts
    func refreshFacts(completion: (() -> Void)? = nil) {
        FactsService.fetchFactsList { [weak self] factsData, error in
            //assign to local facts array to our returned model to refresh View
            self?.facts = factsData
        }
    }
}
