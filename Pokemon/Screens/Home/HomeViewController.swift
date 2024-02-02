//
//  HomeViewController.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 01/02/2024.
//

import Combine
import UIKit

class HomeViewController: UIViewController, Nibbable {
    var viewModel: HomeViewModel!

    private var subscriptions: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubscribers()
        
        viewModel.load()
    }
}

// MARK: - Setup

private extension HomeViewController {
    func setupSubscribers() {
        viewModel.snapshotPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] snapshot in
                print("Snapshot: \(snapshot)")
            }
            .store(in: &subscriptions)
    }
}
