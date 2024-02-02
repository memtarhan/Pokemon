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

    /// Navigate to details publisher - triggered with selection of an item
    var toDetailsPublisher: AnyPublisher<Int, Never> { get }

    /// Loads a Pokemon
    func load()

    /// Informs about last displayed item in Pokemon list
    /// - Parameter indexPath: Index path of last displayed item
    func willDisplayItem(atIndexPath indexPath: IndexPath)

    /// Inform selection of an item
    /// - Parameter indexPath: Index path of selected item
    func didSelectItem(atIndexPath indexPath: IndexPath)

    /// Cancels search
    func cancelSearch()

    /// Informs with searched keyword
    /// - Parameter keyword: Searched keyword
    func search(keyword: String)
}

class HomeViewModelImplemented: HomeViewModel {
    var snapshotPublisher: AnyPublisher<pokemonListSnapshot, Never> {
        snapshot.eraseToAnyPublisher()
    }

    var toDetailsPublisher: AnyPublisher<Int, Never> {
        navigateToDetails.eraseToAnyPublisher()
    }

    private let snapshot = PassthroughSubject<pokemonListSnapshot, Never>()
    private var snapshotModel = pokemonListSnapshot()

    private let navigateToDetails = PassthroughSubject<Int, Never>()

    /*
     This is used for pagination. API does not provide a collection type fetch, so, we have to fetch Pokemons one by one with currentId incremented
     */
    private var currentId = 1

    private let repository: PokemonRepository
    private let favoriteRepository: FavoritePokemonRepository

    init(repository: PokemonRepository, favoriteRepository: FavoritePokemonRepository) {
        self.repository = repository
        self.favoriteRepository = favoriteRepository
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
//        if indexPath.row == snapshotModel.itemIdentifiers(inSection: .main).count - 1 {
//            // Load more
//            currentId += 1
//            load()
//        }
    }

    func didSelectItem(atIndexPath indexPath: IndexPath) {
        guard let pokemon = snapshotModel.itemIdentifiers(inSection: .main)[indexPath.row] as? PokemonCollectionModel else {
            return
        }

//        navigateToDetails.send(pokemon.id)

        Task {
            try? await favoriteRepository.favorite(pokemonWithId: pokemon.id)
        }
    }

    func cancelSearch() {
        snapshot.send(snapshotModel)
    }

    func search(keyword: String) {
        let filteredModels = (snapshotModel.itemIdentifiers(inSection: .main) as! [PokemonCollectionModel]).filter { $0.name.contains(keyword.lowercased()) }
        var filteredSnapshot = pokemonListSnapshot()
        filteredSnapshot.appendSections([.main])
        filteredSnapshot.appendItems(filteredModels, toSection: .main)
        snapshot.send(filteredSnapshot)
    }
}
