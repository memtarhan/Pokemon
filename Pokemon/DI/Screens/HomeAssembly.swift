//
//  HomeAssembly.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 01/02/2024.
//

import Swinject
import UIKit

class HomeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeViewController.self) { _ in
            HomeViewController.instantiate()
        }
    }
}
