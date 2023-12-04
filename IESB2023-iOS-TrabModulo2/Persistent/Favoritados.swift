//
//  Favoritados.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 04/12/23.
//

import Foundation

class Favoritado {
    static let shared = Favoritado()

    var todos: [String] = []

    required init() {
        self.todos = []
    }

    func estado(cod: String) -> Bool {
//        print("Estado(\(String(describing: cod))): '\(todos.contains(cod))'")
//        print("Array 'todos': \(String(describing: todos))")
        return todos.contains(cod)
    }

    func toggle(cod: String) {
        if( estado(cod: cod) ) {
            self.remove(cod: cod)
        } else {
            self.add(cod: cod)
        }
    }

    func add(cod: String) {
        if( todos.firstIndex(of: cod) == nil ) {
            todos.append(cod)
        }
    }

    func remove(cod: String) {
        guard let pos = todos.firstIndex(of: cod) else {
            return
        }
        todos.remove(at: pos)
    }
}
