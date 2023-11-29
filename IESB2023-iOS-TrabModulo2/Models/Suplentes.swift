//
//  Suplentes.swift
//  consultalexml
//
//  Created by Marcelo on 14/08/23.
//

import Foundation

struct UmSuplente: Decodable {
    let DescricaoParticipacao: String
    let CodigoParlamentar: String
    let NomeParlamentar: String
    
    enum CodingKeys: CodingKey {
        case DescricaoParticipacao
        case CodigoParlamentar
        case NomeParlamentar
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.DescricaoParticipacao = try container.decode(String.self, forKey: .DescricaoParticipacao)
        self.CodigoParlamentar = try container.decode(String.self, forKey: .CodigoParlamentar)
        self.NomeParlamentar = try container.decode(String.self, forKey: .NomeParlamentar)
    }
}

struct SuplenteArr: Decodable {
    let Suplente: [UmSuplente]
    
    enum CodingKeys: CodingKey {
        case Suplente
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Suplente = try container.decode([UmSuplente].self, forKey: .Suplente)
    }
}
