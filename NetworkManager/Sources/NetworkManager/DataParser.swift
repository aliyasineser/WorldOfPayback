//
//  DataParser.swift
//  
//
//  Created by Ali Yasin Eser on 04.05.23.
//

import Foundation

public protocol DataParser {
    func parse<T: Decodable>(data: Data) throws -> T
}

final class DefaultDataParser: DataParser {
    private var jsonDecoder: JSONDecoder

    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
    }

    func parse<T: Decodable>(data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
