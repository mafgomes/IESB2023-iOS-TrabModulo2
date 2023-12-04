//
//  SenadorMapView.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 04/12/23.
//

import SwiftUI
import MapKit

struct SenadorMapView: View {
    @ObservedObject var viewModel: SenadorMapViewModel

    var body: some View {
        Map(
            coordinateRegion: $viewModel.region,
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: .constant(.none),
            annotationItems: viewModel.annotations
        ) { annotation in
            MapMarker(coordinate: annotation.coordinate, tint: .blue)
        }
        .onAppear {
            viewModel.requestLocationAuthorization()
        }
    }
}

//#Preview {
//    SenadorMapView(viewModel: <#SenadorMapViewModel#>)
//}
