//
//  PokemonDetailsViewController.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import Combine
import SwiftUI
import UIKit

class PokemonDetailsViewController: UIViewController, Nibbable {
    var viewModel: PokemonDetailsViewModel!
    var pokemonId: Int?

    // MARK: - IBOutlets

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    private var subscriptions: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubscribers()

        guard let pokemonId else {
            dismiss(animated: true)
            return
        }

        viewModel.load(pokemonId: pokemonId)
    }

    func startLoading() {
        activityIndicator.startAnimating()
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
    }
}

// MARK: - Setup

private extension PokemonDetailsViewController {
    func setupSubscribers() {
        viewModel.detailsPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] details in
                self?.stopLoading()
                self?.display(details: details)
            }
            .store(in: &subscriptions)
    }
}

private extension PokemonDetailsViewController {
    func display(details: PokemonDetailsModel) {
        navigationItem.title = details.name
        
        let detailsView = PokemonDetailsView(pokemon: details)

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
