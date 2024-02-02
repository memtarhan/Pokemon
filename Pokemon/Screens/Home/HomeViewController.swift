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

    // MARK: - IBOutlets

    @IBOutlet var collectionView: UICollectionView!

    private var subscriptions: Set<AnyCancellable> = []

    private lazy var sections = PokemonListSection.allCases
    private lazy var dataSource = generatedDataSource

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupSubscribers()

        viewModel.load()
    }

    private var generatedDataSource: UICollectionViewDiffableDataSource<PokemonListSection, CollectionModel> {
        UICollectionViewDiffableDataSource<PokemonListSection, CollectionModel>(collectionView: collectionView) { _, indexPath, model in
            let section = self.sections[indexPath.section]

            switch section {
            case .main:
                guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier, for: indexPath) as? PokemonCollectionViewCell else {
                    return UICollectionViewCell()
                }

                cell.configure(withCollection: model)

                return cell
            }
        }
    }
}

// MARK: - Setup

private extension HomeViewController {
    func setupUI() {
        title = "Pokemon"

        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.collectionViewLayout = createComponsitionalLayout()

        collectionView.register(UINib(nibName: "PokemonCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier)
    }

    func setupSubscribers() {
        viewModel.snapshotPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] snapshot in
                self?.dataSource.apply(snapshot)
            }
            .store(in: &subscriptions)

        viewModel.toDetailsPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] id in
                self?.presentPokemonDetails(pokemonId: id)
            }
            .store(in: &subscriptions)
    }
}

// MARK: - ComponsitionalLayout

private extension HomeViewController {
    func createComponsitionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            let section = self.sections[sectionIndex]

            switch section {
            case .main:
                return self.mainSection
            }
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16
        layout.configuration = config

        return layout
    }

    var mainSection: NSCollectionLayoutSection {
        let fraction: CGFloat = 1 / 3

        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        // Section
        let section = NSCollectionLayoutSection(group: group)

        return section
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.willDisplayItem(atIndexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(atIndexPath: indexPath)
    }
}

// MARK: - Router

extension HomeViewController: Router { }
