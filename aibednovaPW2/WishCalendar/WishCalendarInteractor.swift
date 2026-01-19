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
    func loadStart() {
        loadEvents()
    }
    
    func loadEvents() {
        let fetchRequest: NSFetchRequest<WishEvent> = WishEvent.fetchRequest()
        do {
            try events = context.fetch(fetchRequest)
        } catch {
            fatalError("Failed to fetch WishEvent: \(error)")
        }
        
        let newIndexPath = IndexPath(row: events.count - 1, section: 1)
        
        presenter.presentLoadEvents(Model.Fetch.Response(events: events, indexPath: newIndexPath))
    }
    
    func showWishEventCreationViewController(_ request: Model.ShowWishEventCreationViewController.Request) {
        
        presenter.presentWishEventCreationViewController(Model.ShowWishEventCreationViewController.Response(updateCalendarEvents: request.updateCalendarEvents))
    }
}
