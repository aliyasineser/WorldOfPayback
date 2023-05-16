//
//  RequestManagerFactory.swift
//  
//
//  Created by Ali Yasin Eser on 06.05.23.
//

import Foundation

public final class RequestManagerFactory {

    public init() {}

    public func make() -> RequestManager {
        DefaultRequestManager() 
    }
}
