//
//  HTTPService.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 01/02/2024.
//

import Foundation

protocol HTTPService {
    func handleDataTask<T: HTTPResponse>(from url: URL) async throws -> T
}

extension HTTPService {
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return decoder
    }

    var session: URLSession {
        URLSession.shared
    }

    func handleDataTask<T: HTTPResponse>(from url: URL) async throws -> T {
        let (data, _) = try await session.data(from: url)
        data.printPrettied()
        return try decoder.decode(T.self, from: data)
    }
}
