//
//  RetornoDaApi.swift
//  consultalexml
//
//  Created by Marcelo on 14/08/23.
//

import Foundation

struct DadoRetornado: Decodable {
    let XmlNS_Xsi: String
    let Xsi_noNSSchemaLoc: String
    let Metadados: TipoMetadados
    let Parlamentares: TipoParlamentares // Basicamente, [Senador]

    enum CodingKeys: String, CodingKey {
        case XmlNS_Xsi = "@xmlns:xsi"
        case Xsi_noNSSchemaLoc = "@xsi:noNamespaceSchemaLocation"
        case Metadados = "Metadados"
        case Parlamentares = "Parlamentares"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.XmlNS_Xsi = try container.decode(String.self, forKey: .XmlNS_Xsi)
        self.Xsi_noNSSchemaLoc = try container.decode(String.self, forKey: .Xsi_noNSSchemaLoc)
        self.Metadados = try container.decode(TipoMetadados.self, forKey: .Metadados)
        self.Parlamentares = try container.decode(TipoParlamentares.self, forKey: .Parlamentares)
    }
}

struct DadosRetornados: Decodable {
    let ListaParlamentarEmExercicio: DadoRetornado

    enum CodingKeys: CodingKey {
        case ListaParlamentarEmExercicio
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ListaParlamentarEmExercicio = try container.decode(DadoRetornado.self, forKey: .ListaParlamentarEmExercicio)
    }
}
