//
//  HTTPResponse.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 01/02/2024.
//

import Foundation

protocol HTTPResponse: Decodable { }

// MARK: - PokemonResponse

struct PokemonResponse: HTTPResponse {
    let id: Int
    let name: String
}
