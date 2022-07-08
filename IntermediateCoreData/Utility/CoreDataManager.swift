//
//  CoreDataManager.swift
//  IntermediateCoreData
//
//  Created by YJ.Lee on 2022/7/8.
//

import CoreData

struct CoreDataManager {
    static let shared: CoreDataManager = .init()

    let persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "IntermediateCoreDataModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }
        return persistentContainer
    }()

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
