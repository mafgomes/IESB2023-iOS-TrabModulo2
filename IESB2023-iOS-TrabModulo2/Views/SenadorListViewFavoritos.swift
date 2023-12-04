//
//  SenadorListViewFavoritos.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 04/12/23.
//

import SwiftUI

struct SenadorListViewFavoritos: View {
    @ObservedObject var viewModel: SenadorListViewModel

    init(viewModel: SenadorListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        let parImpar: ParOuImpar = ParOuImpar()

        NavigationStack {
            List(viewModel.favoritosListItemModels) { item in
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
