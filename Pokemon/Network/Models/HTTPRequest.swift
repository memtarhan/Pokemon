//
//  HTTPRequest.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import Foundation

protocol HTTPRequest: Encodable {
    func createURLRequest(withURL url: URL, httpMethod: String) throws -> URLRequest
}

extension HTTPRequest {
    private var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.keyEncodingStrategy = .convertToSnakeCase

        return encoder
    }

    func createURLRequest(withURL url: URL, httpMethod: String = "POST") throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let httpBody = try encoder.encode(self)
        request.httpBody = httpBody

        return request
    }
}

// MARK: - FavoritePokemonRequest

struct FavoritePokemonRequest: HTTPRequest {
    let id: Int
}
