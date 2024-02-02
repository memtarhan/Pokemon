//
//  ScreenFactory.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 01/02/2024.
//

import Foundation
import Swinject

// MARK: Sort it by name

protocol ScreenFactory: AnyObject {
    var home: HomeViewController { get }
    var pokemonDetails: PokemonDetailsViewController { get }
}

class ScreenFactoryImplemented: ScreenFactory {
    private let assembler: Assembler

    init(assembler: Assembler) {
        self.assembler = assembler
    }

    var home: HomeViewController { assembler.resolver.resolve(HomeViewController.self)! }
    var pokemonDetails: PokemonDetailsViewController { assembler.resolver.resolve(PokemonDetailsViewController.self)! }
}
