//
//  SenadorListService.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 15/11/23.
//

import Foundation

protocol SenadorListServiceable {
    func fetchSenadorList() async throws -> [Senador]
}

final class SenadorListService: SenadorListServiceable {
    func fetchSenadorList() async throws -> [Senador] {
        var retVal: [Senador] = []

        let urlString = "https://legis.senado.leg.br/dadosabertos/senador/lista/atual"
        print("URL: \(urlString)")

        // Constatei que não é necessário usar guard let aqui!
        let url = URL(string: urlString)!
        // O compilador não reclama, e como a string é constante, está ok.

        // Agora a gente cria o request, que vai nos permitir
        // Fazer com que a API retorne JSON, ao invés de XML:
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue("application/json", forHTTPHeaderField: "Accept")

        let session = URLSession.shared

        do {
            let(data, _) = try await session.data(for: req)
            let response = try JSONDecoder().decode(DadosRetornados.self, from: data)
            retVal = response.ListaParlamentarEmExercicio.Parlamentares.Parlamentar
        } catch {
            if let _ = error as? URLError {
                //print(error as? URLError)
                throw ParlamentarError.erroNaURL
            } else if let _ = error as? DecodingError {
                // print(error as? DecodingError)
                throw ParlamentarError.erroNaDecodificacao
            } else {
                // print(error)
                throw ParlamentarError.deuOutroPau
            }
        }
        return retVal
    }
}
