//
//  SenadorListViewModel.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 28/11/23.
//

import Foundation

@MainActor
class SenadorListViewModel: ObservableObject {
    private let service: SenadorServiceable

    @Published var listItemModels: [Senador] = []
    @Published var searchText: String = ""
    @Published var selectedItemModel: Senador?

    var filteredListItemModels: [Senador] {
        searchText.isEmpty ?
        listItemModels :
        listItemModels.filter {
            $0.IdentificacaoParlamentar.NomeParlamentar.uppercased().contains(searchText.uppercased()) ||
            $0.IdentificacaoParlamentar.NomeCompletoParlamentar.uppercased().contains(searchText.uppercased()) ||
            $0.IdentificacaoParlamentar.Bloco.NomeBloco.uppercased().contains(searchText.uppercased()) ||
            $0.IdentificacaoParlamentar.Bloco.NomeApelido.uppercased().contains(searchText.uppercased()) ||
            $0.IdentificacaoParlamentar.SiglaPartidoParlamentar.uppercased().contains(searchText.uppercased())
        }
    }

    init(service: SenadorServiceable) {
        self.service = service
    }

    func fetchData() {
        Task {
            do {
                self.listItemModels = try await service
                    .fetchSenadorList(page: 1)
                    .map {
                        try Senador(
                            nome: $0.IdentificacaoParlamentar.NomeParlamentar,
                            legenda: $0.IdentificacaoParlamentar.SiglaPartidoParlamentar,
                            estado: $0.IdentificacaoParlamentar.UfParlamentar,
                            eMail: $0.IdentificacaoParlamentar.EmailParlamentar,
                            imageURL: $0.IdentificacaoParlamentar.UrlFotoParlamentar?.formatted() ?? ""
                        )
                    }
            } catch {
                print(error)
            }
        }
    }
}
