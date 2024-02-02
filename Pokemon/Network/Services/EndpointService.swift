//
//  EndpointService.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 01/02/2024.
//

import Foundation

struct EndpointService {
    struct Pokemon {
        static func get(withId id: Int) -> URL? {
            URL(string: "\(baseURL)/pokemon/\(id)")
        }
    }

    struct PokemonDetails {
        static func get(withId id: Int) -> URL? {
            URL(string: "\(baseURL)/pokemon-species/\(id)")
        }
    }
}

fileprivate let baseURL = "https://pokeapi.co/api/v2"
