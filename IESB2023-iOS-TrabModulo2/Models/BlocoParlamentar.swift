//
//  BlocoParlamentar.swift
//  consultalexml
//
//  Created by Marcelo on 14/08/23.
//

import Foundation

struct BlocoParlamentar: Decodable {
    let CodigoBloco: String
    let NomeBloco: String
    let NomeApelido: String
    let DataCriacao: String
    
    enum CodingKeys: CodingKey {
        case CodigoBloco
        case NomeBloco
        case NomeApelido
        case DataCriacao
    }
    
    init(nomeBloco: String) throws {
        self.NomeBloco = nomeBloco
        self.NomeApelido = nomeBloco
        self.DataCriacao = DISPATCH_WALLTIME_NOW.formatted()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.CodigoBloco = try container.decode(String.self, forKey: .CodigoBloco)
        self.NomeBloco = try container.decode(String.self, forKey: .NomeBloco)
        self.NomeApelido = try container.decode(String.self, forKey: .NomeApelido)
        self.DataCriacao = try container.decode(String.self, forKey: .DataCriacao)
    }
}
