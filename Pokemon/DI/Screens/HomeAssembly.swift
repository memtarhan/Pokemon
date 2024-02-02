//
//  HomeAssembly.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 01/02/2024.
//

import Swinject
import UIKit

class HomeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeViewController.self) { resolver in
            let view = HomeViewController.instantiate()
            let viewModel = resolver.resolve(HomeViewModel.self)!

            view.viewModel = viewModel

            return view
        }

        container.register(HomeViewModel.self) { resolver in
            HomeViewModelImplemented(repository: resolver.resolve(PokemonRepository.self)!,
                                     favoriteRepository: resolver.resolve(FavoritePokemonRepository.self)!)
        }
    }
}
