//
//  Viewable.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 04/02/2024.
//

import Foundation

/// A protocol for view controllers  with basic functions for set up
protocol Viewable {
    /// Sets up UI elements
    func setupUI()

    /// Sets up subscribers of data binding (Combine)
    func setupSubscribers()
}
