//
//  SenadorListView.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 15/11/23.
//

import SwiftUI

@MainActor
struct SenadorListView: View {
    @StateObject var listViewModel: SenadorListViewModel = .init(
        service: SenadorListService()
    )

    var body: some View {
        SenadorListViewNavigationStack(viewModel: listViewModel)
    }
}

 #Preview {
     SenadorListView()
 }
