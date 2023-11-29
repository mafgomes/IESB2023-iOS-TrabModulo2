//
//  SenadorListDetailView.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 29/11/23.
//

import SwiftUI

struct SenadorListDetailView: View {
    private let item: SenadorListViewModel

    @State var isSheetPresented = false

    init(item: SenadorListViewModel) {
        self.item = item
    }

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)

            VStack {

                await AsyncImage(url: await item.fetchData()) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
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
                        Text(item.title)
                            .font(.title3)
                            .foregroundColor(.black)

                        Text(item.subtitle)
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    .background(Color.white)
                }

                Button("Show Sheet Navigation") {
                    isSheetPresented.toggle()
                }
                .background(Color.red)
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            Text("Sheet Presented")
        }
    }
}

struct SenadorListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SenadorListDetailView(
            item: .init(
                nome: "Nome",
                legenda: "Legenda",
                estado: "Estado",
                estado: "eMail",
                imageURL: URL(
                    string: "https://sm.ign.com/ign_br/cover/a/apple-visi/apple-vision-pro_tdy9.jpg"
                )
            )
        )
    }
}


#Preview {
    SenadorListDetailView()
}
