//
//  PokemonRepository.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 01/02/2024.
//

import Foundation

protocol PokemonRepository: HTTPService {
    func getPokemon(withId id: Int) async throws -> PokemonResponse
}

class PokemonRepositoryImplemented: PokemonRepository {
    func getPokemon(withId id: Int) async throws -> PokemonResponse {
        guard let url = EndpointService.Pokemon.get(withId: id) else { throw HTTPError.invalidEndpoint }

        let response: PokemonResponse = try await handleDataTask(from: url)
        return response
    }
}
