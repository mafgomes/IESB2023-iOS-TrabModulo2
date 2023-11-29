//
//  SenadorListViewNavigationSplitView.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 29/11/23.
//

import SwiftUI

struct SenadorListViewNavigationSplitView: View {
    @ObservedObject var senadorViewModel: SenadorListViewModel

    init(
        senadorViewModel: SenadorListViewModel
    ) {
        self.senadorViewModel = senadorViewModel
    }

    var body: some View {
        NavigationSplitView {
            List(senadorViewModel.filteredListItemModels) { item in
                Button {
                    senadorViewModel.selectedItemModel = item
                } label: {
//                    SenadorListItemView(model: item)
                    SenadorListItemView()
                }
            }
            .onAppear {
                senadorViewModel.fetchData()
            }
            .navigationTitle("Senadores")
            .searchable(text: $senadorViewModel.searchText)
        } detail: {
            if let selectedItemModel = senadorViewModel.selectedItemModel {
                SenadorListDetailView(item: selectedItemModel)
            } else {
                Text("Selecione o senador")
            }
        }
    }
}

struct ListViewNavigationSplitView_Previews: PreviewProvider {
    static var previews: some View {
        SenadorListViewNavigationSplitView(
            senadorViewModel: SenadorListViewModel(
                service: SenadorServicePreview()
            )
        )
    }
}

fileprivate final class SenadorServicePreview: SenadorServiceable {
    func fetchSenadorList(page: Int) async throws -> [Senador] {
        let resultsString = """
        [
        {
        "id": 1,
        "name": "Rick Sanchez",
        "status": "Alive",
        "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
        },
        {
        "id": 2,
        "name": "Morty Smith",
        "status": "Alive",
        "image": "https://rickandmortyapi.com/api/character/avatar/2.jpeg"
        },
        {
        "id": 3,
        "name": "Summer Smith",
        "status": "Alive",
        "image": "https://rickandmortyapi.com/api/character/avatar/3.jpeg"
        },
        {
        "id": 4,
        "name": "Beth Smith",
        "status": "Alive",
        "image": "https://rickandmortyapi.com/api/character/avatar/4.jpeg"
        },
        {
        "id": 5,
        "name": "Jerry Smith",
        "status": "Alive",
        "image": "https://rickandmortyapi.com/api/character/avatar/5.jpeg"
        }
        ]
        """

        guard let jsonData = resultsString.data(using: .utf8) else {
            return []
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Senador].self, from: jsonData)
        } catch {
            print("Erro ao decodificar JSON: \(error)")
            return []
        }
    }
}
//
//#Preview {
//    SenadorListViewNavigationSplitView()
//}
