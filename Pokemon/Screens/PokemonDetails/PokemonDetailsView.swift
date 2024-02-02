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
        List {
            ForEach(pokemon.entries, id: \.self) { entry in
                HStack {
                    KFImage(pokemon.frontImageURL)
                        .resizable()
                        .frame(width: 45, height: 45)
                    Text(entry)
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    PokemonDetailsView(pokemon: PokemonDetailsModel.sample)
}
