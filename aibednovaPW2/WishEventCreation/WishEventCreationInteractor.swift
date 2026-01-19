//
//  WishEventCreationInteractor.swift
//  aibednovaPW2
//
//  Created by loxxy on 16.01.2026.
//

import CoreData

class WishEventCreationInteractor : WishEventCreationBusinessLogic {
    // MARK: - Constants
    private enum Constants {
        // Strings
        static let containerName: String = "WishDataModel"
    }
    
    // MARK: - Fields
    private var presenter: WishEventCreationPresentationLogic
    
    var updateCalendarEvents: (() -> Void)?
    
    // Core data
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.containerName)
          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              if let error = error as NSError? {
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          })
          return container
      }()
    
    private lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
      }()
    
    // MARK: - Lifecycle
    init(presenter: WishEventCreationPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Business logic
    func addWish(_ request: Model.AddWishEvent.Request) {
        let event: WishEvent = WishEvent(context: context)
        let requestEvent = request.wishEvent
        
        event.title = requestEvent.title
        event.eventDescription = requestEvent.description
        event.startDate = requestEvent.startDate
        event.endDate = requestEvent.endDate
        
        saveContext()
        
        updateCalendarEvents?()
    }
    
    func saveContext () {
          if context.hasChanges {
              do {
                  try context.save()
              } catch {
                context.rollback()
                  let nserror = error as NSError
                  fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
              }
          }
      }
    
}
