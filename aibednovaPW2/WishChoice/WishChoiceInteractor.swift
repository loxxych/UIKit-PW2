//
//  WishChoiceInteractor.swift
//  aibednovaPW2
//
//  Created by loxxy on 20.01.2026.
//

import CoreData

final class WishChoiceInteractor : WishChoiceBusinessLogic {
    // MARK: - Constants
    private enum Constants {
        // Text
        static let containerName: String = "WishDataModel"
    }
    
    // MARK: - Fields
    private var presenter: WishChoicePresentationLogic
    
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
    
    private var wishes: [WishEvent] = []
    
    // MARK: - Lifecycle
    init(presenter: WishChoicePresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func laodWishes() {
        let fetchRequest: NSFetchRequest<Wish> = Wish.fetchRequest()
        do {
            try wishes = context.fetch(fetchRequest)
        } catch {
            fatalError("\(Constants.errorMsg)\(error)")
        }
        
        let newIndexPath = IndexPath(row: wishes.count - 1, section: 0)
        
        presenter.presentLoadEvents(Model.Fetch.Response(events: wishes, indexPath: newIndexPath))
    }
}
