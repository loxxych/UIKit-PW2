//
//  WishStoringInteractor.swift
//  aibednovaPW2
//
//  Created by loxxy on 08.11.2025.
//

import UIKit

final class WishStoringInteractor : WishStoringBusinessLogic {
    // MARK: -Conctsants
    enum Constants {
        // Strings
        static let wishesKey: String = "wishes"
        static let errorMsg: String = "Unable to save context"
    }
    
    // MARK: - Fields
    private let presenter: WishStoringPresentationLogic
    
    // Core data properties
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let defaults: UserDefaults = UserDefaults.standard
    
    // Wishes
    private var wishes: [Wish] = []
    
    // MARK: - Lifecycle methods
    init(presenter: WishStoringPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Business Logic
    // Is called upon opening the WishStoringView
    func loadStart(_ request: Model.Start.Request) {
        getAllWishes() // Get wishes from core data
        presenter.presentStart(Model.Start.Response(wishes: wishes))
    }
    
    // Adds new wish to wishes
    func addWish(_ request: Model.AddWish.Request) {
        // Initializing new wish for core data
        let wish = Wish(context: context)
        wish.wishText = request.wishText
        
        saveContext()
    }
    
    // Deletes wish from wishes
    func deleteWish(_ request: Model.DeleteWish.Request) {
        context.delete(request.wish)
        saveContext()
    }
    
    // Toggles cell edit mode
    func editWish(_ request: Model.EditWish.Request) {
        presenter.presentEditWish(Model.EditWish.Response(indexPath: request.indexPath))
    }
    
    // Changes wishText of wish
    func sendWish(_ request: Model.SendWish.Request) {
        request.wish.wishText = request.newWishText
        presenter.presentSendWish(Model.SendWish.Response(indexPath: request.indexPath))
    }
    
    // Updates wishes to current ones
    func loadWishes(_ request: Model.Fetch.Request) {
        getAllWishes() // Get wishes from core data

        let newIndexPath = IndexPath(row: wishes.count - 1, section: 1)
        
        presenter.presentLoadWishes(Model.Fetch.Response(wishes: wishes, indexPath: newIndexPath))
    }
    
    // MARK: - Utility core data functions
    // Updates local wish array with wishes from core data
    private func getAllWishes() {
        do {
            wishes = try context.fetch(Wish.fetchRequest())
        }
        catch {
            fatalError()
        }
    }
    
    // Saves wish to context
    private func saveContext() {
        do {
            try context.save()
        }
        catch {
            fatalError(Constants.errorMsg)
        }
    }
}
