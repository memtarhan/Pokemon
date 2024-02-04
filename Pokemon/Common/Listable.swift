//
//  Listable.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 04/02/2024.
//

import Foundation

/// A protocol for view models that are used to display a list of items
protocol Listable {
    /// Informs about last displayed item in Pokemon list
    /// - Parameter indexPath: Index path of last displayed item
    func willDisplayItem(atIndexPath indexPath: IndexPath)

    /// Inform selection of an item
    /// - Parameter indexPath: Index path of selected item
    func didSelectItem(atIndexPath indexPath: IndexPath)
}
