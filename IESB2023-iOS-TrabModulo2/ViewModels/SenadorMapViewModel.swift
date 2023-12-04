//
//  SenadorMapViewModel.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 04/12/23.
//

import SwiftUI
import MapKit
import CoreLocation

class SenadorMapViewModel: NSObject, ObservableObject {

    // MARK: CoreLocation

    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var cityPlaceMark: CLPlacemark?
    @Published var lastUserLocation: CLLocation?

    private let locationManager: CLLocationManager

    // MARK: MapKit

    @Published var region: MKCoordinateRegion = .init(
        center: .init(latitude: 41.14961, longitude: -8.61099),
        span: .init(latitudeDelta: 0.025, longitudeDelta: 0.025)
    )
    @Published var annotations: [SenadorMapAnnotationModel] = SenadorAnnotations
    @Published var selectedAnnotation: SenadorMapAnnotationModel?

    // MARK: Lifecycle and Methods

    override init() {
        self.locationManager = CLLocationManager()
        self.authorizationStatus = self.locationManager.authorizationStatus
        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //10.0
        locationManager.startUpdatingLocation()
    }

    func selectAnnotation(_ annotation: SenadorMapAnnotationModel) {
        selectedAnnotation = annotation
    }

    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension SenadorMapViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        self.lastUserLocation = locations.first
        //        requestCity()
    }

    private func requestCity() {
        guard let lastUserLocation = lastUserLocation else { return }

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(lastUserLocation) { places, error in
            self.cityPlaceMark = places?.first
        }
    }
}

class SenadorMapAnnotationModel: MKPointAnnotation, Identifiable {
    let id = UUID()
    let imageURL: URL?

    init(
        coordinate: CLLocationCoordinate2D,
        title: String?,
        imageURL: URL?
    ) {
        self.imageURL = imageURL
        super.init()
        self.coordinate = coordinate
        self.title = title
    }
}

let SenadorAnnotations: [SenadorMapAnnotationModel] = [
    SenadorMapAnnotationModel(
        coordinate: CLLocationCoordinate2D(
            latitude: 41.140947,
            longitude: -8.609806
        ),
        title: "Ponte Dom Luís 1",
        imageURL: URL(string: "https://insideporto.com/wp-content/uploads/2016/04/ponte-d.luis_.png")
    ),
    SenadorMapAnnotationModel(
        coordinate: CLLocationCoordinate2D(
            latitude: 41.146544,
            longitude: -8.616930
        ),
        title: "Adega Leonor",
        imageURL: URL(string: "https://fastly.4sqi.net/img/general/600x600/19581930_vZrb3s0pC739an4NGF759W9o9AEcg4ti7KzBv86IOS8.jpg")
    ),
    SenadorMapAnnotationModel(
        coordinate: CLLocationCoordinate2D(
            latitude: 41.145287,
            longitude: -8.610996
        ),
        title: "Estação São Bento",
        imageURL: URL(string: "https://portosecreto.co/wp-content/uploads/2022/05/estacao-sao-bento-shutterstock.jpg")
    ),
    SenadorMapAnnotationModel(
        coordinate: CLLocationCoordinate2D(
            latitude: 41.138160,
            longitude: -8.612320
        ),
        title: "Ribeira Vila Nova de Gaia",
        imageURL: URL(string: "https://cdn.travel-in-portugal.com/sites/default/files/photos/gaia-riverside.jpg")
    ),
    SenadorMapAnnotationModel(
        coordinate: CLLocationCoordinate2D(
            latitude: 41.155647,
            longitude: -8.629736
        ),
        title: "Mercado Bom Sucesso",
        imageURL: URL(string: "https://st3.idealista.pt/news/arquivos/styles/open_graph/public/2021-05/mercado_bom_sucesso_-_nova_imagem.jpg?VersionId=rwvjOqw0voiDJkv3EW0Ee23JkTMUtplv&itok=z5qAZwxa")
    ),
    SenadorMapAnnotationModel(
        coordinate: CLLocationCoordinate2D(
            latitude: 41.159912,
            longitude: -8.659982
        ),
        title: "Parque Serralves",
        imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Fundación_Serralves_o_palacete_de_Miami.jpg/640px-Fundación_Serralves_o_palacete_de_Miami.jpg")
    )
]
