//
//  SenadorListViewModel.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 15/11/23.
//

import Foundation

@MainActor
class SenadorListViewModel: ObservableObject {
    private let service: SenadorListServiceable

    @Published var listItemModels: [SenadorListItemModel] = []
    @Published var searchText: String = ""
    @Published var selectedItemModel: SenadorListItemModel?

    var filteredListItemModels: [SenadorListItemModel] {
        searchText.isEmpty ?
        listItemModels :
        listItemModels.filter {
            $0.nome.uppercased().contains(searchText.uppercased()) ||
            $0.partido.uppercased().contains(searchText.uppercased())
        }
    }

    init(service: SenadorListServiceable) {
        self.service = service
    }

    func fetchData() {
        Task {
            do {
                self.listItemModels = try await service
                    .fetchSenadorList()
                    .map {
                        SenadorListItemModel(
                            cod: $0.IdentificacaoParlamentar.CodigoParlamentar,
                            nome: $0.IdentificacaoParlamentar.NomeParlamentar,
                            nomeCompleto: $0.IdentificacaoParlamentar.NomeCompletoParlamentar,
                            partido: "\($0.IdentificacaoParlamentar.SiglaPartidoParlamentar) / \($0.Mandato.UfParlamentar)",
                            imageURL: $0.IdentificacaoParlamentar.UrlFotoParlamentar,
                            eMail: $0.IdentificacaoParlamentar.EmailParlamentar,
                            telefone: $0.IdentificacaoParlamentar.Telefones.Telefones.first!.NumeroTelefone,
                            escritorio: $0.IdentificacaoParlamentar.UfParlamentar
                        )
                    }
            } catch {
                print(error)
            }
        }
    }
}
