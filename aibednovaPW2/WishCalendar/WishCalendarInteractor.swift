//
//  WishCalendarInteractor.swift
//  aibednovaPW2
//
//  Created by loxxy on 15.01.2026.
//

import CoreData

class WishCalendarInteractor : WishCalendarBusinessLogic {
    // MARK: - Constants
    private enum Constants {
        static let containerName: String = "WishDataModel"
        static let errorMsg: String = "Failed to fetch WishEvent: "
        static let format: String = "title == %@ AND startDate == %@"
        static let deleteErrorMsg: String = "Delete error: "
    }
    
    // MARK: - Fields
    private var presenter: WishCalendarPresentationLogic

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
    
    private var events: [WishEvent] = []
    
    // MARK: - Lifecycle
    init(presenter: WishCalendarPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Business logic
    func loadEvents() {
        let fetchRequest: NSFetchRequest<WishEvent> = WishEvent.fetchRequest()
        do {
            try events = context.fetch(fetchRequest)
        } catch {
            fatalError("\(Constants.errorMsg): \(error)")
        }
        
        let newIndexPath = IndexPath(row: events.count - 1, section: 0)
        
        presenter.presentLoadEvents(Model.Fetch.Response(events: events, indexPath: newIndexPath))
    }
    
    func deleteEvent(_ request: Model.Delete.Request) {
        let fetchRequest: NSFetchRequest<WishEvent> = WishEvent.fetchRequest()

            fetchRequest.predicate = NSPredicate(
                format: Constants.format,
                request.event.title,
                request.event.startDate as NSDate
            )

            do {
                let results = try context.fetch(fetchRequest)
                results.forEach { context.delete($0) }
                try context.save()
            } catch {
                print("\(Constants.deleteErrorMsg): \(error)")
            }

            loadEvents()
    }
    
    func showWishEventCreationViewController(_ request: Model.ShowWishEventCreationViewController.Request) {
        
        presenter.presentWishEventCreationViewController(Model.ShowWishEventCreationViewController.Response(updateCalendarEvents: request.updateCalendarEvents))
    }
}
