//
//  SenadorListItemView.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 28/11/23.
//

import SwiftUI

struct SenadorListItemView: View {
    var body: some View {
        HStack {
            Image("foto").imageScale(.small)
            VStack(alignment: .leading, spacing: 5) {
                Text("Nome do Senador").font(.headline)
                Text("Partido / Estado").font(.caption)
                Text("e-mail do senador").font(.caption)
            }
            Spacer(minLength: 5)
        }
    }
}

#Preview {
    SenadorListItemView()
}
