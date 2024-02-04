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
        view.backgroundColor = .pokePrimaryBackground
        
        navigationItem.title = "Pokemon"

        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.collectionViewLayout = createComponsitionalLayout()
        collectionView.keyboardDismissMode = .onDrag
        
        collectionView.register(UINib(nibName: "PokemonCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: PokemonCollectionViewCell.reuseIdentifier)

        let search = UISearchController(searchResultsController: nil)
        search.delegate = self
        search.searchBar.delegate = self
        navigationItem.searchController = search
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
        let layout = UICollectionViewCompositionalLayout { [unowned self] sectionIndex, environment in
            let section = self.sections[sectionIndex]

            switch section {
            case .main:
                return self.layoutSection(forIndex: sectionIndex, environment: environment)
            }
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16
        layout.configuration = config

        return layout
    }

    private func layoutSection(forIndex index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // approximate width we want to base our calculations on
        let desiredWidth: CGFloat = 200

        let itemCount = environment.container.effectiveContentSize.width / desiredWidth

        let fractionWidth: CGFloat = 1 / (itemCount.rounded())

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fractionWidth), heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .small()

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(fractionWidth))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        return NSCollectionLayoutSection(group: group)
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

// MARK: - UISearchControllerDelegate

extension HomeViewController: UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.cancelSearch()
    }
}

// MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            viewModel.cancelSearch()
            return
        }
        viewModel.search(keyword: searchText)
    }
}

// MARK: - Router

extension HomeViewController: Router { }
