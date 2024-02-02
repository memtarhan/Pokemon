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

    private var session: URLSession {
        URLSession.shared
    }

    func securedSession(withToken token: String) -> URLSession {
        let authValue = "Bearer \(token)"

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpAdditionalHeaders = ["Authorization": authValue]
        let session = URLSession(configuration: sessionConfig, delegate: self as? URLSessionDelegate, delegateQueue: nil)

        return session
    }

    func handleDataTask<T: HTTPResponse>(from url: URL) async throws -> T {
        let (data, _) = try await session.data(from: url)
        data.printPrettied()
        return try decoder.decode(T.self, from: data)
    }

    func handleSecuredDataTask<T: HTTPResponse>(_ session: URLSession, for urlRequest: URLRequest) async throws -> T {
        let (data, _) = try await session.data(for: urlRequest)
        data.printPrettied()
        return try decoder.decode(T.self, from: data)
    }
}
