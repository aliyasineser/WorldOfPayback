//
//  File.swift
//  
//
//  Created by Ali Yasin Eser on 06.05.23.
//

import Foundation

public final class DataParserFactory {

    public init() {}
    
    public func make() -> DataParser {
        DefaultDataParser()
    }
}
