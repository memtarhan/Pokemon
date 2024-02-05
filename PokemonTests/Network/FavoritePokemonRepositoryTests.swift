//
//  FavoritePokemonRepositoryTests.swift
//  PokemonTests
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

@testable import Pokemon
import XCTest

// MARK: Those tests are for demonstration, Of course, there should be more and more tests

final class FavoritePokemonRepositoryTests: XCTestCase {
    private var repository: FavoritePokemonRepository!

    override func setUpWithError() throws {
        repository = StubFavoritePokemonRepository()
    }

    func testGetPokemonDecoding() async throws {
        _ = try await repository.favorite(pokemonWithId: 25)
    }
}
