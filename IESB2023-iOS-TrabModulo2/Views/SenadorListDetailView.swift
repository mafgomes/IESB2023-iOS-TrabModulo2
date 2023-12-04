//
//  SenadorListDetailView.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 15/11/23.
//

import SwiftUI

struct SenadorListDetailView: View {
    private let im: SenadorListItemModel

    @State private var st = false
    @State private var favStr: String?
    @State private var favIcon: String?
    @State var isSheetPresented = false
    private var fav = Favoritado.shared

    init(itemModel: SenadorListItemModel) {
        self.im = itemModel
        updateState()
    }

    func formatTel(tel: String) -> String {
        let posHifen = 4
        return "\(tel.prefix(tel.count - posHifen))-\(tel.suffix(posHifen))"
    }

    func updateState() {
        st = fav.estado(cod: im.cod)
        favStr = st ? " Favorito " : " Favoritar "
        favIcon = st ? "star.fill" : "star"
    }

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Label(favStr ?? " - ", systemImage: favIcon ?? "homekit")
                    .background(.white)
                    .padding(5)
                    .onAppear {
                        updateState()
                    }
                    .onTapGesture {
                        fav.toggle(cod: im.cod)
                        updateState()
                    }

                AsyncImage(url: im.imageURL) { phase in
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
                        Text(im.nome)
                            .font(.largeTitle)

                        Text(" Nome Completo: \(im.nomeCompleto) ")

                        HStack {
                            Text("Legenda:")
                            Text(im.partido)
                                .font(.headline)
                        }
                        
                        Text("").padding(5)
                        Label("[\(im.eMail)](mailto:\(im.eMail))", systemImage: "envelope")
                        Text("").padding(5)
                        Label("[\(formatTel(tel: im.telefone))](tel://+5561\(im.telefone))", systemImage: "phone")
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
                cod: "12345",
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
