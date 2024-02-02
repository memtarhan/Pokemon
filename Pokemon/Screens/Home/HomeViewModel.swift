//
//  HomeViewModel.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import Combine
import Foundation

protocol HomeViewModel {
    /// Pokemon publisher with requested data
    var snapshotPublisher: AnyPublisher<pokemonListSnapshot, Never> { get }

    /// Loads a Pokemon
    func load()
    
    func willDisplayItem(atIndexPath indexPath: IndexPath)
}

class HomeViewModelImplemented: HomeViewModel {
    var snapshotPublisher: AnyPublisher<pokemonListSnapshot, Never> {
        snapshot.eraseToAnyPublisher()
    }

    private let snapshot = PassthroughSubject<pokemonListSnapshot, Never>()
    private var snapshotModel = pokemonListSnapshot()

    /*
     This is used for pagination. API does not provide a collection type fetch, so, we have to fetch Pokemons one by one with currentId incremented
     */
    private var currentId = 1

    private let repository: PokemonRepository

    init(repository: PokemonRepository) {
        self.repository = repository
        snapshotModel.appendSections(PokemonListSection.allCases)
    }

    func load() {
        print(#function)

        Task {
            do {
                let response = try await repository.getPokemon(withId: currentId)
                let model = PokemonCollectionModel(withResponse: response)
                snapshotModel.appendItems([model], toSection: .main)
                snapshot.send(snapshotModel)

            } catch {
                print(error)
                // TODO: Display error alert
            }
        }
    }

    func willDisplayItem(atIndexPath indexPath: IndexPath) {
        if indexPath.row == snapshotModel.itemIdentifiers(inSection: .main).count - 1 {
            // Load more
            currentId += 1
            load()
        }
    }
}
