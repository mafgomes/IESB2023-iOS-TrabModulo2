//
//  IdentSenador.swift
//  consultalexml
//
//  Created by Marcelo on 14/08/23.
//

import Foundation

struct IdentSenador: Decodable {
    let CodigoParlamentar: String
    let CodigoPublicoNaLegAtual: String
    let NomeParlamentar: String
    let NomeCompletoParlamentar: String
    let SexoParlamentar: String
    let FormaTratamento: String
    let UrlFotoParlamentar: URL?
    let UrlPaginaParlamentar: URL?
    let EmailParlamentar: String
    let Telefones: TipoTelefones
    let SiglaPartidoParlamentar: String
    let UfParlamentar: String
    let Bloco: BlocoParlamentar
    let MembroMesa: String
    let MembroLideranca: String
    
    enum CodingKeys: CodingKey {
        case CodigoParlamentar
        case CodigoPublicoNaLegAtual
        case NomeParlamentar
        case NomeCompletoParlamentar
        case SexoParlamentar
        case FormaTratamento
        case UrlFotoParlamentar
        case UrlPaginaParlamentar
        case EmailParlamentar
        case Telefones
        case SiglaPartidoParlamentar
        case UfParlamentar
        case Bloco
        case MembroMesa
        case MembroLideranca
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.CodigoParlamentar = try container.decode(String.self, forKey: .CodigoParlamentar)
        // print("CodigoParlamentar: '\(self.CodigoParlamentar)'")
        self.CodigoPublicoNaLegAtual = try container.decode(String.self, forKey: .CodigoPublicoNaLegAtual)
        // print("CodigoPublicoNaLegAtual: '\(self.CodigoPublicoNaLegAtual)'")
        self.NomeParlamentar = try container.decode(String.self, forKey: .NomeParlamentar)
        // print("NomeParlamentar: '\(self.NomeParlamentar)'")
        self.NomeCompletoParlamentar = try container.decode(String.self, forKey: .NomeCompletoParlamentar)
        // print("NomeCompletoParlamentar: '\(self.NomeCompletoParlamentar)'")
        self.SexoParlamentar = try container.decode(String.self, forKey: .SexoParlamentar)
        // print("SexoParlamentar: '\(self.SexoParlamentar)'")
        self.FormaTratamento = try container.decode(String.self, forKey: .FormaTratamento)
        // print("FormaTratamento: '\(self.FormaTratamento)'")

        let urlFotoStr = try container.decode(String.self, forKey: .UrlFotoParlamentar)
        self.UrlFotoParlamentar = URL(string: urlFotoStr.replacingOccurrences(of: "http:", with: "https:"))
        // print("UrlFotoParlamentar: '\(String(describing: self.UrlFotoParlamentar))'")

        let urlPaginaStr = try container.decode(String.self, forKey: .UrlPaginaParlamentar)
        self.UrlPaginaParlamentar = URL(string: urlPaginaStr.replacingOccurrences(of: "http:", with: "https:"))
        // print("UrlPaginaParlamentar: '\(String(describing: self.UrlPaginaParlamentar))'")

        self.EmailParlamentar = try container.decode(String.self, forKey: .EmailParlamentar)
        // print("EmailParlamentar: '\(self.EmailParlamentar)'")
        self.Telefones = try container.decode(TipoTelefones.self, forKey: .Telefones)
        // print("Telefones: '\(self.Telefones)'")
        self.SiglaPartidoParlamentar = try container.decode(String.self, forKey: .SiglaPartidoParlamentar)
        // print("SiglaPartidoParlamentar: '\(self.SiglaPartidoParlamentar)'")
        self.UfParlamentar = try container.decode(String.self, forKey: .UfParlamentar)
        // print("UfParlamentar: '\(self.UfParlamentar)'")

        self.Bloco = try container.decode(BlocoParlamentar.self, forKey: .Bloco)
        // print("Bloco: '\(self.Bloco)'")
        self.MembroMesa = try container.decode(String.self, forKey: .MembroMesa)
        // print("MembroMesa: '\(self.MembroMesa)'")
        self.MembroLideranca = try container.decode(String.self, forKey: .MembroLideranca)
        // print("MembroLideranca: '\(self.MembroLideranca)'")
    }
}
