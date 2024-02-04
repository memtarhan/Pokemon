//
//  StubFavoritePokemonRepository.swift
//  PokemonTests
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import Foundation
@testable import Pokemon

class StubFavoritePokemonRepository: FavoritePokemonRepository {
    func favorite(pokemonWithId id: Int) async throws -> FavoritePokemonResponse {
        guard let url = EndpointService.FavoritePokemon.favorite() else { throw HTTPError.invalidEndpoint }
        let request = FavoritePokemonRequest(id: id)
        let urlRequest = try request.createURLRequest(withURL: url)

        let response: FavoritePokemonResponse = try await handleDataTask(from: url)
        return response
    }
}
