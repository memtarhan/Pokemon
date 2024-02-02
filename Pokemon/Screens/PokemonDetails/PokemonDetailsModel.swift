//
//  PokemonDetailsModel.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import Foundation

struct PokemonDetailsModel {
    let name: String
    let frontImageURL: URL
    let backImageURL: URL
    let entries: [String]

    static let sample = PokemonDetailsModel(name: "pikachu",
                                            frontImageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png")!,
                                            backImageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/25.png")!,
                                            entries: ["Entry 1", "Entry 2"])
}
