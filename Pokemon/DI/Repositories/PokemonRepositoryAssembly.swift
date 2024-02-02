//
//  PokemonRepositoryAssembly.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import Foundation
import Swinject

class PokemonRepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PokemonRepository.self) { _ in
            PokemonRepositoryImplemented()
        }
    }
}
