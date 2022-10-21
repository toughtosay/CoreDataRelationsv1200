//
//  CoreDataRelationsv1200App.swift
//  CoreDataRelationsv1200
//
//  Created by Andree Carlsson on 2022-10-21.
//

import SwiftUI

@main
struct CoreDataRelationsv1200App: App {
    
    // MARK: Här initierar vi PersistenceControllern som vi byggt i filen "Persistence"
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            // MARK: Här lägger vi till alla delarna i environment(osäker på exakt varför fråga Bill), lägger även till Navigationstack ovan, ska vara nytt i IOS 16. Varför?
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
