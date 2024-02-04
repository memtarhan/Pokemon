//
//  FavoritePokemonRepository.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import Foundation

protocol FavoritePokemonRepository: HTTPService {
    func favorite(pokemonWithId id: Int) async throws -> FavoritePokemonResponse
}

class FavoritePokemonRepositoryImplemented: FavoritePokemonRepository {
    func favorite(pokemonWithId id: Int) async throws -> FavoritePokemonResponse {
        guard let url = EndpointService.FavoritePokemon.favorite() else { throw HTTPError.invalidEndpoint }
        let request = FavoritePokemonRequest(id: id)
        let urlRequest = try request.createURLRequest(withURL: url)

        let response: FavoritePokemonResponse = try await handleSecuredDataTask(securedSession(withToken: "testsk_6p8XKZAuac9xZv4fL0R7_1gji-CfpGnK.eu"), for: urlRequest)
        return response
    }
}
