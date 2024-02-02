//
//  PokemonDetailsViewController.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import SwiftUI
import UIKit

class PokemonDetailsViewController: UIViewController {
    var pokemonId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

private extension PokemonDetailsViewController {
    func setupUI() {
        let detailsView = PokemonDetailsView(pokemon: PokemonDetailsModel.sample)

        let config = UIHostingConfiguration {
            detailsView
        }
        let detailsUIView = config.makeContentView()

        detailsUIView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(detailsUIView)

        NSLayoutConstraint.activate([
            detailsUIView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsUIView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailsUIView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailsUIView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
