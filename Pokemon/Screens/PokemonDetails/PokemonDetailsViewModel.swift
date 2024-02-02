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

    init(repository: PokemonRepository) {
        self.repository = repository
    }

    func load(pokemonId: Int) {
        print(#function)

        Task {
            do {
                let response = try await repository.getPokemon(withId: pokemonId)
                let model = PokemonDetailsModel(name: response.name,
                                                frontImageURL: URL(string: response.sprites.frontDefault)!,
                                                backImageURL: URL(string: response.sprites.backDefault)!)
                details.send(model)

            } catch {
                print(error)
                // TODO: Display error alert
            }
        }
    }
}
