//
//  Telefones.swift
//  consultalexml
//
//  Created by Marcelo on 14/08/23.
//

import Foundation

struct TipoTelefone: Decodable {
    let NumeroTelefone: String
    let OrdemPublicacao: String
    let IndicadorFax: String
    
    enum CodingKeys: CodingKey {
        case NumeroTelefone
        case OrdemPublicacao
        case IndicadorFax
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.NumeroTelefone = try container.decode(String.self, forKey: .NumeroTelefone)
//        print("Numero: '\(NumeroTelefone)'")
        self.OrdemPublicacao = try container.decode(String.self, forKey: .OrdemPublicacao)
        self.IndicadorFax = try container.decode(String.self, forKey: .IndicadorFax)
    }
}

struct TipoTelefones: Decodable {
    let Telefones: [TipoTelefone]

    enum CodingKeys: CodingKey {
        case Telefone
    }

    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.Telefones = [try container.decode(TipoTelefone.self, forKey: .Telefone)]
        } catch {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.Telefones = try container.decode([TipoTelefone].self, forKey: .Telefone)
        }
    }
}
