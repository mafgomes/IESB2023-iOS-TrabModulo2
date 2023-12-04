//
//  SenadorListView.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 15/11/23.
//

import SwiftUI

struct SenadorListViewNavigationStack: View {
    @ObservedObject var viewModel: SenadorListViewModel

    init(viewModel: SenadorListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        let parImpar: ParOuImpar = ParOuImpar()

        NavigationStack {
            List(viewModel.filteredListItemModels) { item in
                NavigationLink(value: item) {
                    SenadorListItemView(model: item, cinza: parImpar)
                }
            }
            .onAppear {
                viewModel.fetchData()
            }
            .navigationTitle("Senadores")
            .navigationDestination(for: SenadorListItemModel.self) { item in
                SenadorListDetailView(itemModel: item)
            }
            .searchable(text: $viewModel.searchText)
        }
    }
}
//
//struct SenadorListViewNavigationStack_Previews: PreviewProvider {
//    static var previews: some View {
//        SenadorListViewNavigationStack(
//            viewModel: SenadorListViewModel(
//                service: SenadorListServicePreview()
//            )
//        )
//    }
//}
//
//fileprivate final class SenadorListServicePreview: SenadorListServiceable {
//    func fetchSenadorList() async throws -> [Senador] {
//        let resultsString = """
//        [
//        {
//        "id": 1,
//        "name": "Rick Sanchez",
//        "status": "Alive",
//        "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
//        },
//        {
//        "id": 2,
//        "name": "Morty Smith",
//        "status": "Alive",
//        "image": "https://rickandmortyapi.com/api/character/avatar/2.jpeg"
//        },
//        {
//        "id": 3,
//        "name": "Summer Smith",
//        "status": "Alive",
//        "image": "https://rickandmortyapi.com/api/character/avatar/3.jpeg"
//        },
//        {
//        "id": 4,
//        "name": "Beth Smith",
//        "status": "Alive",
//        "image": "https://rickandmortyapi.com/api/character/avatar/4.jpeg"
//        },
//        {
//        "id": 5,
//        "name": "Jerry Smith",
//        "status": "Alive",
//        "image": "https://rickandmortyapi.com/api/character/avatar/5.jpeg"
//        }
//        ]
//        """
//
//        guard let jsonData = resultsString.data(using: .utf8) else {
//            return []
//        }
//
//        do {
//            let decoder = JSONDecoder()
//            return try decoder.decode([Senador].self, from: jsonData)
//        } catch {
//            print("Erro ao decodificar JSON: \(error)")
//            return []
//        }
//    }
//}
