//
//  PokemonDetailsRepositoryAssembly.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import Foundation
import Swinject

class PokemonDetailsRepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PokemonDetailsRepository.self) { _ in
            PokemonDetailsRepositoryImplemented()
        }
    }
}
