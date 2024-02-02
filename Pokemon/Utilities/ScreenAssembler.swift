//
//  ScreenAssembler.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 01/02/2024.
//

import Swinject
import UIKit

class ScreenAssembler {
    static let shared = ScreenAssembler()

    private(set) var assembler: Assembler?

    /// - Initializing dependency injection
    func initDI() {
        assembler = Assembler([
            /// - Screens
            HomeAssembly(),
            PokemonDetailsAssembly(),

            /// - Repositories
            FavoritePokemonRepositoryAssembly(),
            PokemonDetailsRepositoryAssembly(),
            PokemonRepositoryAssembly(),

        ])
        assembler?.apply(assembly: FactoryAssemby(assembler: assembler!))
    }
}
