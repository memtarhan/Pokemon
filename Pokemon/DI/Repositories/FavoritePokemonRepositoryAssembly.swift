//
//  FavoritePokemonRepositoryAssembly.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import Foundation
import Swinject

class FavoritePokemonRepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FavoritePokemonRepository.self) { _ in
            FavoritePokemonRepositoryImplemented()
        }
    }
}
