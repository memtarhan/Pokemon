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

    // MARK: Could also carry over actual Pokemon data here but for API call demonstration and better testing, I used pokemonId

    var pokemonId: Int?

    // MARK: - IBOutlets

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    private var subscriptions: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupSubscribers()

        guard let pokemonId else {
            dismiss(animated: true)
            return
        }

        viewModel.load(pokemonId: pokemonId)
    }

    // MARK: Those functions could be moved to a parent class for wide use

    func startLoading() {
        activityIndicator.startAnimating()
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
    }
}

// MARK: - Viewable

extension PokemonDetailsViewController: Viewable {
    func setupUI() {
        view.backgroundColor = .pokePrimaryBackground
    }

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
                .clipShape(RoundedRectangle(cornerRadius: 20))

            // MARK: Can customise SwiftUI view here as well
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
