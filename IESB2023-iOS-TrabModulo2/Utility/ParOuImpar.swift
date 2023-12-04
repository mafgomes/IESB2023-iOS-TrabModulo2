//
//  ParOuImpar.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 03/12/23.
//

import Foundation

struct ParOuImpar {
    static var parImpar: Bool = false

    func curr() -> Bool {
        return ParOuImpar.parImpar
    }

    func prox() -> Bool {
        ParOuImpar.parImpar = !ParOuImpar.parImpar
        return ParOuImpar.parImpar
    }
}
