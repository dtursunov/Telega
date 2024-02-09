//
//  CoreDataManager.swift
//  Telega
//
//  Created by Diyor Tursunov on 09/02/24.
//

import Foundation
import CoreData

protocol DataLayer {
    func create<T: NSManagedObject>(entity: T.Type, properties: [String: Any]) -> T?
    func getAll<T: NSManagedObject>(entity: T.Type) -> [T]
    func delete<T: NSManagedObject>(entity: T)
    func append<T: NSManagedObject>(entities: [T])
    func saveContext()
    var mainContext: NSManagedObjectContext { get }
}

class CoreDataStack: DataLayer {

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BookStorage")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func create<T: NSManagedObject>(entity: T.Type, properties: [String: Any]) -> T? {
            let context = mainContext
            guard let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: entity), in: context) else {
                return nil
            }

            let newObject = T(entity: entityDescription, insertInto: context)
            properties.forEach { key, value in
                newObject.setValue(value, forKey: key)
            }

            saveContext()
            return newObject
        }

    func getAll<T: NSManagedObject>(entity: T.Type) -> [T] {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: entity))
        do {
            let objects = try mainContext.fetch(fetchRequest)
            return objects
        } catch {
            print("Failed to fetch \(entity) objects: \(error)")
            return []
        }
    }
    
    func append<T: NSManagedObject>(entities: [T]) {
        for entity in entities {
            mainContext.insert(entity)
        }
        saveContext()
    }



    func delete<T: NSManagedObject>(entity: T) {
        mainContext.delete(entity)
        saveContext()
    }
}


private extension NSManagedObject {
    var entityProperties: [String: Any] {
        var properties = [String: Any]()
        let mirror = Mirror(reflecting: self)
        for case let (label?, value) in mirror.children {
            properties[label] = value
        }
        return properties
    }
}
