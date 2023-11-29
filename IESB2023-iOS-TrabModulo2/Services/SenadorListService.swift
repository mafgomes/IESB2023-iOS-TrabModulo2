//
//  SenadorListService.swift
//  consultalexml
//
//  Created by Marcelo on 14/08/23.
//

import Foundation

protocol SenadorServiceable {
    func fetchSenadorList(page: Int) async throws -> [Senador]
}

final class SenadorListService: SenadorListServiceable {
    func fetchSenadorList(
        completion: @escaping (Result<DadosRetornados,
                               ParlamentarError>) -> Void
    ) {
        let urlString = "https://legis.senado.leg.br/dadosabertos/senador/lista/atual"
        print("URL: \(urlString)")
        
        // Constatei que não é necessário usar guard let aqui!
        let url = URL(string: urlString)!
        // O compilador não reclama, e como a string é constante, está ok.
        
        // Faz com que a API retorne JSON, ao invés de XML:
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Agora podemos fazer a requisição:
        let task = URLSession.shared.dataTask(with: req) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.deuOutroPau))
                return
            }
            
            do {
                // Debug, para ver se recebemos os dados conforme esperado:
                //                print("Dados recebidos antes do JSONDecoder:")
                //                for ind in data {
                //                    print("\(Character(UnicodeScalar(ind)))", terminator: "")
                //                }
                //                print("Chegando ao JSONDecoder:")
                
                let response = try JSONDecoder().decode(DadosRetornados.self, from: data)
                completion(.success(response))
            } catch let error as DecodingError {
                print("JSONDecoder() retornou: '\(data)' e '\(error)'")
                print("Erro de decodificação: '\(data)', do tipo \(type(of: data))")
                completion(.failure(.deuOutroPau))
            } catch {
                print(error)
                completion(.failure(.deuOutroPau))
            }
        }
        
        task.resume()
    }
    
    func fetchSenadorList() async throws -> [Senador] {
        let urlString = "https://legis.senado.leg.br/dadosabertos/senador/lista/atual"
        print("URL: \(urlString)")

        // Constatei que não é necessário usar guard let aqui!
        let url = URL(string: urlString)!
        // O compilador não reclama, e como a string é constante, está ok.

        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(DadosRetornados.self, from: data)
            return response.ListaParlamentarEmExercicio.Parlamentares.Parlamentar
        } catch {
            if let urlError = error as? URLError {
                throw ParlamentarError.erroNaURL
            } else if let _ = error as? DecodingError {
                throw ParlamentarError.erroNaDecodificacao
            } else {
                throw ParlamentarError.deuOutroPau
            }
        }
    }
}
