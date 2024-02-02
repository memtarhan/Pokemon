//
//  NSDirectionalEdgeInsets+.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import UIKit

extension NSDirectionalEdgeInsets {
    static func uniform(size: CGFloat) -> NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets(top: size, leading: size, bottom: size, trailing: size)
    }

    static func small() -> NSDirectionalEdgeInsets {
        return .uniform(size: 5)
    }
}
