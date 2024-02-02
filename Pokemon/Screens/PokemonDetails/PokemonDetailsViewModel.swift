//
//  PokemonDetailsViewModel.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import Combine
import Foundation

protocol PokemonDetailsViewModel {
    /// Pokemon publisher with requested data
    var detailsPublisher: AnyPublisher<PokemonDetailsModel, Never> { get }

    /// Loads details of a Pokemon with given ID
    func load(pokemonId: Int)
}

class PokemonDetailsViewModelImplemented: PokemonDetailsViewModel {
    var detailsPublisher: AnyPublisher<PokemonDetailsModel, Never> {
        details.eraseToAnyPublisher()
    }

    private let details = PassthroughSubject<PokemonDetailsModel, Never>()

    private let repository: PokemonRepository
    private let detailsRepository: PokemonDetailsRepository

    init(repository: PokemonRepository, detailsRepository: PokemonDetailsRepository) {
        self.repository = repository
        self.detailsRepository = detailsRepository
    }

    func load(pokemonId: Int) {
        print(#function)

        Task {
            do {
                let pokemonResponse = try await repository.getPokemon(withId: pokemonId)
                let detailsResponse = try await detailsRepository.getDetails(withId: pokemonId)

                let entries = detailsResponse.flavorTextEntries.map { $0.flavorText }
                let model = PokemonDetailsModel(name: pokemonResponse.name,
                                                frontImageURL: URL(string: pokemonResponse.sprites.frontDefault)!,
                                                backImageURL: URL(string: pokemonResponse.sprites.backDefault)!,
                                                entries: entries)
                details.send(model)

            } catch {
                print(error)
                // TODO: Display error alert
            }
        }
    }
}
