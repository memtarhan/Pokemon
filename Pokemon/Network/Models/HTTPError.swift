//
//  HTTPError.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 01/02/2024.
//

import Foundation

enum HTTPError: Error, CustomStringConvertible {
    case failed
    case invalidEndpoint
    case invalidData
}

extension HTTPError {
    var description: String {
        switch self {
        case .failed:
            return "Failed to connect"
        case .invalidEndpoint:
            return "Invalid endpoint"
        case .invalidData:
            return "Invalid data"
        }
    }
}
