//
//  PokemonDetailsView.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 02/02/2024.
//

import Kingfisher
import SwiftUI

struct PokemonDetailsView: View {
    var pokemon: PokemonDetailsModel

    var body: some View {
        VStack {
            KFImage(pokemon.frontImageURL)
                .resizable()
                .frame(width: 128, height: 128)
            Text(pokemon.name)
        }
    }
}

#Preview {
    PokemonDetailsView(pokemon: PokemonDetailsModel.sample)
}
