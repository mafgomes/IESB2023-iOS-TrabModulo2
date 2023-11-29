//
//  DescrMandato.swift
//  consultalexml
//
//  Created by Marcelo on 14/08/23.
//

import Foundation

struct DescrMandato: Decodable {
    let CodigoMandato: String
    let UfParlamentar: String
    let PrimeiraLegislaturaDoMandato: Legislatura
    let SegundaLegislaturaDoMandato: Legislatura
    let DescricaoParticipacao: String
    let Suplentes: SuplenteArr?
    let Exercicios: ExercicioArr
    
    enum CodingKeys: CodingKey {
        case CodigoMandato
        case UfParlamentar
        case PrimeiraLegislaturaDoMandato
        case SegundaLegislaturaDoMandato
        case DescricaoParticipacao
        case Suplentes
        case Exercicios
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.CodigoMandato = try container.decode(String.self, forKey: .CodigoMandato)
        self.UfParlamentar = try container.decode(String.self, forKey: .UfParlamentar)
        self.PrimeiraLegislaturaDoMandato = try container.decode(Legislatura.self, forKey: .PrimeiraLegislaturaDoMandato)
        self.SegundaLegislaturaDoMandato = try container.decode(Legislatura.self, forKey: .SegundaLegislaturaDoMandato)
        self.DescricaoParticipacao = try container.decode(String.self, forKey: .DescricaoParticipacao)
        do {
            self.Suplentes = try container.decode(SuplenteArr.self, forKey: .Suplentes)
        } catch {
            self.Suplentes = nil
        }
        self.Exercicios = try container.decode(ExercicioArr.self, forKey: .Exercicios)
    }
}
