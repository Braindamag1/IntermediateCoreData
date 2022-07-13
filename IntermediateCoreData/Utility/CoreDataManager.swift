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
    
    var companies:[CDCompany] {
        let fetchRequest = NSFetchRequest<CDCompany>(entityName: "CDCompany")
        do {
            let companies = try viewContext.fetch(fetchRequest)
            return companies
        } catch let fetchError {
            print("Failed to fetch companies:",fetchError)
            fatalError()
        }
    }
    
    var companyModelArray:[Company] {
        return companies.map { company in
            let name = company.name ?? ""
            let date = company.date ?? Date()
            return Company(name: name, founded: date)
        }
    }
}
