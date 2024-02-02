//
//  HomeModel.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import Foundation
import UIKit

class PokemonCollectionModel: CollectionModel {
    let name: String
    let frontImage: String
    let backImage: String

//    init(id: Int, name: String, frontImage: String, backImage: String) {
//        self.name = name
//        self.frontImage = frontImage
//        self.backImage = backImage
//
//        super.init(id: id)
//    }

    init(withResponse response: PokemonResponse) {
        name = response.name
        frontImage = response.sprites.frontDefault
        backImage = response.sprites.backDefault

        super.init(id: response.id)
    }
}

typealias pokemonListSnapshot = NSDiffableDataSourceSnapshot<PokemonListSection, CollectionModel>
