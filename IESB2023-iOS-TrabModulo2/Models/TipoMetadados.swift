//
//  TipoMetadados.swift
//  consultalexml
//
//  Created by Marcelo on 14/08/23.
//

import Foundation

struct TipoMetadados: Decodable {
    let Versao: String
    let VersaoServico: String
    let DataVersaoServico: String
    let DescricaoDataSet: String
    
    enum CodingKeys: CodingKey {
        case Versao
        case VersaoServico
        case DataVersaoServico
        case DescricaoDataSet
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Versao = try container.decode(String.self, forKey: .Versao)
        self.VersaoServico = try container.decode(String.self, forKey: .VersaoServico)
        self.DataVersaoServico = try container.decode(String.self, forKey: .DataVersaoServico)
        self.DescricaoDataSet = try container.decode(String.self, forKey: .DescricaoDataSet)
    }
}
