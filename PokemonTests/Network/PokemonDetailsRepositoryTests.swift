//
//  PokemonDetailsRepositoryTests.swift
//  PokemonTests
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

@testable import Pokemon
import XCTest

// MARK: Those tests are for demonstration, Of course, there should be more and more tests

final class PokemonDetailsRepositoryTests: XCTestCase {
    private var repository: PokemonDetailsRepository!

    override func setUpWithError() throws {
        repository = StubPokemonDetailsRepository()
    }

    func testGetPokemonDetailsDecoding() async throws {
        _ = try await repository.getDetails(withId: 1)
    }
}
