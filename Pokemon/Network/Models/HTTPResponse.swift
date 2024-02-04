//
//  HTTPResponse.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 01/02/2024.
//

import Foundation

protocol HTTPResponse: Decodable { }

// MARK: - PokemonSpritesResponse

struct PokemonSpritesResponse: HTTPResponse {
    let backDefault: String
    let frontDefault: String
}

// MARK: - PokemonResponse

struct PokemonResponse: HTTPResponse {
    let id: Int
    let name: String
    let sprites: PokemonSpritesResponse
}

// MARK: - FlavorTextEntryResponse

struct FlavorTextEntryResponse: HTTPResponse {
    let flavorText: String
}

// MARK: - PokemonDetailsResponse

struct PokemonDetailsResponse: HTTPResponse {
    let flavorTextEntries: [FlavorTextEntryResponse]
}

// MARK: - FavoritePokemonResponse

struct FavoritePokemonResponse: HTTPResponse {
    let id: Int
}
