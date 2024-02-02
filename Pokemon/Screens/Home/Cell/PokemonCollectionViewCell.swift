//
//  PokemonCollectionViewCell.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "Pokemon"

    @IBOutlet var containerView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.layer.cornerRadius = 20.0
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        containerView.layer.shadowRadius = 2.0
        containerView.layer.shadowOpacity = 0.7
    }

    func configure(withCollection collection: CollectionModel) {
        guard let pokemon = collection as? PokemonCollectionModel else {
            // TODO: Display a placeholder when data is not configured right
            return
        }

        nameLabel.text = pokemon.name
        imageView.loadImage(urlString: pokemon.frontImage)
    }
}
