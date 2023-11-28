//
//  IESB2023_iOS_TrabModulo2App.swift
//  IESB2023-iOS-TrabModulo2
//
//  Created by Marcelo A F Gomes on 21/10/23.
//

import SwiftUI

@main
struct IESB2023_iOS_TrabModulo2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
