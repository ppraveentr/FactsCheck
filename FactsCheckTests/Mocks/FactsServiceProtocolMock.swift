//
//  FactsServiceProtocolMock.swift
//  FactsCheckTests
//
//  Created by Praveen P on 09/04/20.
//  Copyright © 2020 Praveen P. All rights reserved.
//

@testable import FactsCheck
import UIKit

final class NetworkManagerProtocolMock: NetworkManagerProtocol{
    static var shared: NetworkManagerProtocol = NetworkManagerProtocolMock()
    
    private(set) var makeServiceCalled = false
    private(set) var downloadedImageCalled = false

    func makeService<T>(url: URL, responseType: T.Type, completion: CompletionHandler?) where T : Decodable, T : Encodable {
        makeServiceCalled = true
    }
    
    func downloadedImage(url: URL, allowCache: Bool, _ comletionHandler: ImageViewComletionHandler?) {
        downloadedImageCalled = true
    }
}

final class FactsServiceProtocolMock: FactsServiceProtocol {
    var networkManager: NetworkManagerProtocol = NetworkManagerProtocolMock.shared
    
    private(set) var fetchFactsListCalled = false
    lazy var mockFactDetails: FactDetails? = FactDetailsMock.mockFactDetails()
    var mockFactsError: FactsError? = nil

    var hostUrl: URL?
    
    func fetchFactsList(url: URL?, completion: @escaping FactsCompletionHandler) {
        fetchFactsListCalled = true
        completion(mockFactDetails, mockFactsError)
    }
}
