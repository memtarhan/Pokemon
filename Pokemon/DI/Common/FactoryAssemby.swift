//
//  FactoryAssembler.swift
//  Pokemon
//
//  Created by Mehmet Tarhan on 01/02/2024.
//

import Foundation
import Swinject

class FactoryAssemby: Assembly {
    private let assembler: Assembler

    init(assembler: Assembler) {
        self.assembler = assembler
    }

    func assemble(container: Container) {
        container.register(ScreenFactory.self) { _ in
            ScreenFactoryImplemented(assembler: self.assembler)
        }
    }
}
