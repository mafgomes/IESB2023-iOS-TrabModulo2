//
//  SenadorListDetailView.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 15/11/23.
//

import SwiftUI

struct SenadorListDetailView: View {
    private let itemModel: SenadorListItemModel

    @State var isSheetPresented = false

    init(itemModel: SenadorListItemModel) {
        self.itemModel = itemModel
    }

    func formatTel(tel: String) -> String {
        let posHifen = 4
        return "\(tel.prefix(tel.count - posHifen))-\(tel.suffix(posHifen))"
    }

    var body: some View {
        let favorito: Bool = false
        var favIcon: String = favorito ? "star.fill" : "star"
        var favStr: String = favorito ? "Favorito" : "Favoritar"

        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)

            VStack {
//                Button(favStr, image: Label("", systemImage: favIcon), action: {
//                    isSheetPresented.toggle()
//                })

                AsyncImage(url: itemModel.imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200, alignment: .top)
                            .cornerRadius(100)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    @unknown default:
                        fatalError()
                    }
                }

                ZStack {
                    VStack {
                        Text(itemModel.nome)
                            .font(.largeTitle)

                        Text(" Nome Completo: \(itemModel.nomeCompleto) ")

                        HStack {
                            Text("Legenda:")
                            Text(itemModel.partido)
                                .font(.headline)
                        }
                        
                        Text("").padding(5)
                        Label("[\(itemModel.eMail)](mailto:\(itemModel.eMail))", systemImage: "envelope")
                        Text("").padding(5)
                        Label("[\(formatTel(tel: itemModel.telefone))](tel://+5561\(itemModel.telefone))", systemImage: "phone")
                        Text("").padding(5)
                    }
                    .foregroundColor(.black)
                    .background(Color.white)
                }

                Button(" Localizar Escritório ") {
                    isSheetPresented.toggle()
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(.white)
                .background(Color.gray)
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            Text(" Mapa do Escritório ")
        }
    }
}

struct SenadorListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SenadorListDetailView(
            itemModel: .init(
                nome: "Justo Veríssimo",
                nomeCompleto: "Justo Justíssimo Veríssimo",
                partido: "PQP / AC",
                imageURL: URL(
                    string: "https://thispersondoesnotexist.com/"
                ),
                eMail: "fulano@senado.leg.br",
                telefone: "(66) 2666-6666",
                escritorio: "AC"
            )
        )
    }
}
