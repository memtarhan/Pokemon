//
//  StubFavoritePokemonRepository.swift
//  PokemonTests
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import Foundation
@testable import Pokemon

class StubFavoritePokemonRepository: FavoritePokemonRepository {
    func favorite(pokemonWithId id: Int) async throws {
        guard let url = EndpointService.Pokemon.get(withId: id) else { throw HTTPError.invalidEndpoint }
        let request = FavoritePokemonRequest(id: id)
        let urlRequest = try request.createURLRequest(withURL: url)

        let response: PokemonResponse = try await handleSecuredDataTask(securedSession(withToken: "testsk_6p8XKZAuac9xZv4fL0R7_1gji-CfpGnK.eu"), for: urlRequest)
    }
}
