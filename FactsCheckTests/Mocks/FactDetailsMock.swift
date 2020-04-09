//
//  FactsTableViewModelProtocolMock.swift
//  FactsCheckTests
//
//  Created by Praveen P on 09/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

@testable import FactsCheck
import Foundation

enum FactDetailsMock {
    static func mockFact() -> Fact {
        var fact = Fact()
        fact.title = "title"
        fact.imageHref = "href"
        fact.description = "description"
        return fact
    }
    
    static func mockFactDetails() -> FactDetails {
        var details = FactDetails()
        details.title = "mockTitle"
        details.facts = [FactDetailsMock.mockFact()]
        return details
    }
}

final class FactsViewDelegateMock: NSObject, FactsViewDelegate {
    
    private(set) var refreshTitleCalled = false
    private(set) var showAlertCalled = false
    
    func refreshTitle() {
        refreshTitleCalled = true
    }
    
    func showAlert(message: String) {
        showAlertCalled = true
    }
}

final class FactsTableViewModelProtocolMock: FactsTableViewModelProtocol {
    
    private(set) var numberOfRowsInSectionCalled = false
    private(set) var dataForIndexCalled = false
    private(set) var getFactDetailsCalled = false

    var mockFact = FactDetailsMock.mockFact()
    
    func numberOfRowsInSection() -> Int {
        numberOfRowsInSectionCalled = true
        return 1
    }
    
    func data(forIndexPath indexPath: IndexPath) -> Fact? {
        dataForIndexCalled = true
        return mockFact
    }
    
    func getFactDetails() {
        getFactDetailsCalled = true
    }
}
