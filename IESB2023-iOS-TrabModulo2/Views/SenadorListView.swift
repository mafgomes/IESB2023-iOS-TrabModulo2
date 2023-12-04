//
//  SenadorListView.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 15/11/23.
//

import SwiftUI
import SwiftData

//@MainActor
//struct SenadorListView: View {
//    @StateObject var listViewModel: SenadorListViewModel = .init(
//        service: SenadorListService()
//    )
//
//    var body: some View {
//        SenadorListViewNavigationStack(viewModel: listViewModel)
//    }
//}
//

@MainActor
struct SenadorListView: View {
    @State private var selectedTab: Tab = .todosOsSenadores
    @StateObject var listViewModel: SenadorListViewModel = .init(
        service: SenadorListService()
    )

    enum Tab {
        case todosOsSenadores
        case senadoresFavoritos
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            SenadorListViewTodos(viewModel: listViewModel)
                .tabItem {
                    Label("Todos", systemImage: "person")
                }
                .tag(Tab.todosOsSenadores)

            SenadorListViewFavoritos(viewModel: listViewModel)
                .tabItem {
                    Label("Favoritos", systemImage: "star.fill")
                }
                .tag(Tab.senadoresFavoritos)
        }
        .navigationBarTitle(selectedTab == .todosOsSenadores ? "Todos" : "Favoritos")
    }
}

#Preview {
    SenadorListView()
}
