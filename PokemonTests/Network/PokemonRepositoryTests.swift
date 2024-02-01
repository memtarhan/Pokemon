//
//  PokemonRepositoryTests.swift
//  PokemonTests
//
//  Created by Mehmet Tarhan on 01/02/2024.
//

@testable import Pokemon
import XCTest

final class PokemonRepositoryTests: XCTestCase {
    private var repository: PokemonRepository!

    override func setUpWithError() throws {
        repository = StubPokemonRepository()
    }

    func testGetPokemonDecoding() async throws {
        _ = try await repository.getPokemon(withId: 1)
    }
}
