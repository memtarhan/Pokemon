//
//  DisplayModel.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import Foundation

// MARK: CollectionModel

/// Conforms to NSDiffableDataSource protocol
class CollectionModel: Hashable {
    let id: Int

    init(id: Int) {
        self.id = id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: CollectionModel, rhs: CollectionModel) -> Bool {
        lhs.id == rhs.id
    }
}
