//
//  Persistence.swift
//  CoreDataRelationsv1200
//
//  Created by Andree Carlsson on 2022-10-21.
//

import Foundation
import CoreData
import CloudKit

// MARK: Vår manuellt uppsatta persistenscontroller. Sätter upp BasicFunktinerna som containers.
struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreDataRelationsv1200")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { NSPersistentStoreDescription, err in
            if let err = err {
                fatalError(err.localizedDescription)
            }
        }
    }
    
    // MARK: Vår funktion för att spara till CoreData
    func save() throws {
        let context = container.viewContext
        if context.hasChanges {
            try context.save()
        }
    // MARK: Vår funktion för delete. Den avslutar med att spara ändringarna.
        func delete(_ object: NSManagedObject) throws {
            let context = container.viewContext
            context.delete(object)
            try save()
            
        }
        
    }
}
