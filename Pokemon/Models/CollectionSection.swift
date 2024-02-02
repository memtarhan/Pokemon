//
//  CollectionSection.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import Foundation

// MARK: CollectionSection

protocol CollectionSection: CaseIterable {
    var id: Int { get }
    var title: String? { get }

    init?(fromId id: Int)
}

// MARK: - ExhbtResultSection

enum PokemonListSection: CollectionSection {
    case main

    var id: Int {
        switch self {
        case .main:
            return 0
        }
    }

    var title: String? {
        switch self {
        case .main:
            return nil
        }
    }

    init?(fromId id: Int) {
        switch id {
        case 0:
            self = .main

        default:
            return nil
        }
    }
}
