//
//  File.swift
//  
//
//  Created by Ali Yasin Eser on 06.05.23.
//

import Foundation

public final class APIManagerFactory {

    private let urlSession: URLSession

    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    public func make() -> APIManager {
        DefaultAPIManager(urlSession: urlSession)
    }
}
