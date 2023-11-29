//
//  SenadorListView.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 28/11/23.
//

import SwiftUI

@MainActor
struct SenadorListView: View {
    @StateObject var listViewModel: SenadorListViewModel = .init(service: SenadorListService())

    var body: some View {
        
    }
}

//struct SenadorListView_Preview: PreviewProvider {
//    static var previews: some View {
//        SenadorListView()
//    }
//}

 #Preview {
     SenadorListView()
 }
