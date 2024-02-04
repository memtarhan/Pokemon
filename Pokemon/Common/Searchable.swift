//
//  Searchable.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 04/02/2024.
//

import Foundation

/// A protocol for view models that are used to search an item
protocol Searchable {
    /// Cancels search
    func cancelSearch()

    /// Informs with searched keyword
    /// - Parameter keyword: Searched keyword
    func search(keyword: String)
}
