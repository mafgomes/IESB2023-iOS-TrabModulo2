//
//  Favoritados.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 04/12/23.
//

import SwiftUI


private func saveStrArray(key: String, data: [String]) {
    UserDefaults.standard.set(data, forKey: key)
}

private func loadStrArray(key: String) -> [String] {
    return UserDefaults.standard.stringArray(forKey: key) ?? []
}

public class Favoritado {
    private let key = "favoritadosKey"
    static let shared = Favoritado()

    var todos: [String] {
        didSet {
            saveStrArray(key: key, data: todos)
        }
    }

    required init() {
        self.todos = loadStrArray(key: key)
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
