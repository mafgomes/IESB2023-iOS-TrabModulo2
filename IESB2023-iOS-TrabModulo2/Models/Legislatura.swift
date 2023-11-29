//
//  Legislatura.swift
//  consultalexml
//
//  Created by Marcelo on 14/08/23.
//

import Foundation

struct Legislatura: Decodable {
    let NumeroLegislatura: String
    let DataInicio: String
    let DataFim: String
    
    enum CodingKeys: CodingKey {
        case NumeroLegislatura
        case DataInicio
        case DataFim
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.NumeroLegislatura = try container.decode(String.self, forKey: .NumeroLegislatura)
        self.DataInicio = try container.decode(String.self, forKey: .DataInicio)
        self.DataFim = try container.decode(String.self, forKey: .DataFim)
    }
}
