//
//  SenadorListItemView.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 15/11/23.
//

import SwiftUI

struct SenadorListItemModel: Identifiable, Hashable {
    let id = UUID()
    let cod: String
    let nome: String
    let nomeCompleto: String
    let partido: String
    let imageURL: URL?
    let eMail: String
    let telefone: String
    let escritorio: String
}

struct SenadorListItemView: View {
    private let cod: String
    private let nome: String
    private let nomeCompleto: String
    private let partido: String
    private let imageURL: URL?
    private let eMail: String
    private let telefone: String
    private let escritorio: String
    private var cinza: ParOuImpar

    init(
        model: SenadorListItemModel,
        cinza: ParOuImpar
    ) {
        self.cod = model.cod
        self.nome = model.nome
        self.nomeCompleto = model.nomeCompleto
        self.partido = model.partido
        self.imageURL = model.imageURL
        self.eMail = model.eMail
        self.telefone = model.telefone
        self.escritorio = model.escritorio

        self.cinza = cinza
    }

    func padString(str: String) -> String {
        return str.padding(toLength: 28, withPad: " ", startingAt: 0)
    }

    var body: some View {
        let myBgColor: Color = cinza.prox() ? .gray : .white
        let myFgColor: Color = cinza.curr() ? .white : .black

        HStack {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView() // Exibe uma visualização de progresso enquanto a imagem é carregada.
                case .success(let image):
                    image
                        .resizable()
                case .failure:
                    Image(systemName: "photo") // Exibe uma imagem de substituição se ocorrer um erro ao carregar a imagem.
                        .resizable()
                @unknown default:
                    fatalError()
                }
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50) // Defina o tamanho desejado da imagem.

            VStack(alignment: .leading) {
                Text(padString(str: nome))
                    .font(.headline)
                    .foregroundColor(myFgColor)
                Text(partido)
                    .font(.subheadline)
                    .foregroundColor(myFgColor)
            }
        }
        .background(myBgColor)
        .aspectRatio(contentMode: .fill)
        .fontDesign(.monospaced)
    }
}
