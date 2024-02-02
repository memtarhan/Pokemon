//
//  PokemonDetailsAssembly.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import Swinject
import UIKit

class PokemonDetailsAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PokemonDetailsViewController.self) { resolver in
            let view = PokemonDetailsViewController.instantiate()
            let viewModel = resolver.resolve(PokemonDetailsViewModel.self)!

            view.viewModel = viewModel

            return view
        }

        container.register(PokemonDetailsViewModel.self) { resolver in
            PokemonDetailsViewModelImplemented(repository: resolver.resolve(PokemonRepository.self)!,
                                               detailsRepository: resolver.resolve(PokemonDetailsRepository.self)!)
        }
    }
}
