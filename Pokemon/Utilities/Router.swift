//
//  Router.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import UIKit

// MARK: Sort it by name

/// Provides navigations on view controller that inherits
protocol Router {
    /// Pushes Pokemon Details screen into current navigation stack
    /// - Parameter id: Pokemon ID to be displayed
    func presentPokemonDetails(pokemonId id: Int)
}

extension Router where Self: UIViewController {
    private var factory: ScreenFactory? {
        (ScreenAssembler.shared.assembler?.resolver.resolve(ScreenFactory.self))!
    }

    // MARK: - PokemonDetails

    func presentPokemonDetails(pokemonId id: Int) {
        guard let destination = factory?.pokemonDetails else { return }
        destination.pokemonId = id

        navigationController?.pushViewController(destination, animated: true)
    }
}
