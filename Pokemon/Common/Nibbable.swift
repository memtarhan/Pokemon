//
//  Nibbable.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 01/02/2024.
//

import UIKit

protocol Nibbable {
    static func instantiate() -> Self
}

extension Nibbable where Self: UIViewController {
    /// Instantiates a view controller from a nib with the same name
    /// - Returns: Returns a View Controller
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]

        return Self(nibName: className, bundle: nil)
    }
}
