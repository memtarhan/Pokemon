//
//  HTTPService.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 01/02/2024.
//

import Foundation

protocol HTTPService {
    /// Handles HTTP call and retrieve a response for given url with no authorization
    /// - Parameter url: The url HTTP call should be pointed to
    /// - Returns: Returns a response of given type
    func handleDataTask<T: HTTPResponse>(from url: URL) async throws -> T

    /// Handles HTTP call and retrieve a response for given url with authorization
    /// - Parameters:
    ///   - session: The secured session configured with a token
    ///   - urlRequest: The url requests consist of body data and url that HTTP call should be pointed to
    /// - Returns: Returns a response of given type
    func handleSecuredDataTask<T: HTTPResponse>(_ session: URLSession, for urlRequest: URLRequest) async throws -> T

    /// A secured session configured with given token
    /// - Parameter token: The token that should be configured to a URLSession instance
    /// - Returns: Returns an instance of URLSession configured with given token
    func securedSession(withToken token: String) -> URLSession
}

extension HTTPService {
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

// MARK: Private variables

private extension HTTPService {
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return decoder
    }

    var session: URLSession {
        URLSession.shared
    }
}
