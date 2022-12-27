//
//  PersistenceController.swift
//  CoreDataSync
//

import CoreData
import UIKit

struct PersistenceController {
    static let shared = PersistenceController()
    static var preview: PersistenceController = {
        let result = PersistenceController()
        let viewContext = result.container.viewContext
        for i in 0 ..< 10 {
            
            let newContact = ContentEntity(context: viewContext)
            newContact.name = "File #\(i)"
            newContact.photo = UIImage(systemName: "multiply.circle.fill")
            newContact.time = Date()
            let newFolder = FolderEntity(context : viewContext)
            newFolder.folderName = "Folder #\(i)"
        }
        do {
            try viewContext.save()
        } catch {
            
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "CoreDataSync")
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
