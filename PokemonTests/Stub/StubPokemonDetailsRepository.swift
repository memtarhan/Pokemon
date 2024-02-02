//
//  StubPokemonDetailsRepository.swift
//  PokemonTests
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import Foundation
@testable import Pokemon

class StubPokemonDetailsRepository: PokemonDetailsRepository {
    func getDetails(withId id: Int) async throws -> PokemonDetailsResponse {
        guard let url = EndpointService.PokemonDetails.get(withId: id) else { throw HTTPError.invalidEndpoint }

        let response: PokemonDetailsResponse = try await handleDataTask(from: url)
        return response
    }
}
