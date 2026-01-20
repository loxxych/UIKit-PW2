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
        static let unresolvedErrorMsg: String = "Unresolved error"
    }
    
    // MARK: - Fields
    private var presenter: WishEventCreationPresentationLogic
    
    private let calendarManager: CalendarManaging = CalendarManager()
    
    var updateCalendarEvents: (() -> Void)?
    
    // Core data
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("\(Constants.unresolvedErrorMsg) \(error): \(error.userInfo)")
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
        // Saving event to core data
        let event: WishEvent = WishEvent(context: context)
        let requestEvent = request.wishEvent
        
        if (requestEvent.startDate > requestEvent.endDate) {
            return
        }
        
        event.title = requestEvent.title
        event.eventDescription = requestEvent.description
        event.startDate = requestEvent.startDate
        event.endDate = requestEvent.endDate
        
        saveContext()
        
        // Adding event to calendar
        let calendarEvent = CalendarEventModel(title: requestEvent.title,
                                               startDate: requestEvent.startDate,
                                               endDate: requestEvent.endDate,
                                               note: requestEvent.description)
        
        addToSystemCalendar(eventModel: calendarEvent) { success in }
        
        // Updating event list on the previous screen
        updateCalendarEvents?()
    }
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("\(Constants.unresolvedErrorMsg): \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addToSystemCalendar(eventModel: CalendarEventModel, completion: ((Bool) -> Void)? = nil) {
        let success = calendarManager.create(eventModel: eventModel)
        completion?(success)
    }
    
    func showChooseWishViewController() {
        presenter.showChooseWishViewController()
    }
    
}
