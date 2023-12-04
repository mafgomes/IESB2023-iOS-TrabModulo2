//
//  Senador.swift
//  consultalexml
//
//  Created by Marcelo on 14/08/23.
//

import Foundation

class Contador {
    var val: Int = 0

    required init(valor: Int) {
        self.val = valor
    }
}

func formatTelAsURL(tel: String) -> String {
    let newTel = tel.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    return "tel://+5561\(newTel)"
}

struct Senador: Decodable, Identifiable {
    var oid: ObjectIdentifier
    var id: Int
    var firstTel: String
    var telURL: String

    let IdentificacaoParlamentar: IdentSenador
    let Mandato: DescrMandato
    
    enum CodingKeys: CodingKey {
        case IdentificacaoParlamentar
        case Mandato
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // print("Decodificando Senador...\n")
        self.IdentificacaoParlamentar = try container.decode(IdentSenador.self, forKey: .IdentificacaoParlamentar)
        self.Mandato = try container.decode(DescrMandato.self, forKey: .Mandato)

        let cod = Int.IntegerLiteralType(self.IdentificacaoParlamentar.CodigoParlamentar, radix: 10) ?? 0
        self.oid = ObjectIdentifier(Contador(valor: cod))
        self.id = cod

        self.firstTel = self.IdentificacaoParlamentar.Telefones.Telefones.first?.NumeroTelefone ?? ""
        self.telURL  = formatTelAsURL(tel: self.firstTel)
    }
}
