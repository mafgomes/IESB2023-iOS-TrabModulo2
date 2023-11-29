//
//  TipoParlamentares.swift
//  consultalexml
//
//  Created by Marcelo on 14/08/23.
//

import Foundation

struct TipoParlamentares: Decodable {
    let Parlamentar: [Senador]

    enum CodingKeys: CodingKey {
        case Parlamentar
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.Parlamentar = try container.decode([Senador].self, forKey: .Parlamentar)
    }
}
