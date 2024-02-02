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
        container.register(PokemonDetailsViewController.self) { _ in
            PokemonDetailsViewController()
        }
    }
}
