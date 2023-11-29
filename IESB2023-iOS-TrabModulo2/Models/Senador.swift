//
//  Senador.swift
//  consultalexml
//
//  Created by Marcelo on 14/08/23.
//

import Foundation

class Contador {
    static var val: Int = 0
}

class Senador: Decodable, Identifiable {
    var oid: ObjectIdentifier
    var id: Int

    let IdentificacaoParlamentar: IdentSenador
    let Mandato: DescrMandato
    
    enum CodingKeys: CodingKey {
        case IdentificacaoParlamentar
        case Mandato
    }

    init(
        nome: String,
        legenda: String,
        estado: String,
        eMail: String,
        imageURL: String
    ) throws {
        self.IdentificacaoParlamentar = try IdentSenador(nomeParlamentar: nome, nomeCompletoParlamentar: nome, urlFotoStr: imageURL, eMailParlamentar: eMail, siglaPartidoParlamentar: legenda, bloco: legenda)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.IdentificacaoParlamentar = try container.decode(IdentSenador.self, forKey: .IdentificacaoParlamentar)
        self.Mandato = try container.decode(DescrMandato.self, forKey: .Mandato)
        
        self.oid = ObjectIdentifier(Contador())
        self.id = Contador.val
        Contador.val += 1
    }
}
