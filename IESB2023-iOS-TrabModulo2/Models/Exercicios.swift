//
//  Exercicios.swift
//  consultalexml
//
//  Created by Marcelo on 14/08/23.
//

import Foundation

struct UmExercicio: Decodable {
    let CodigoExercicio: String
    let DataInicio: String
    
    enum CodingKeys: CodingKey {
        case CodigoExercicio
        case DataInicio
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.CodigoExercicio = try container.decode(String.self, forKey: .CodigoExercicio)
        self.DataInicio = try container.decode(String.self, forKey: .DataInicio)
    }
}

struct ExercicioArr: Decodable {
    let Exercicio: [UmExercicio]
    
    enum CodingKeys: CodingKey {
        case Exercicio
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.Exercicio = try container.decode([UmExercicio].self, forKey: .Exercicio)
    }
}
