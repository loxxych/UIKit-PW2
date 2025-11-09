//
//  WishStoringInteractor.swift
//  aibednovaPW2
//
//  Created by loxxy on 08.11.2025.
//
import UIKit

final class WishStoringInteractor : WishStoringInteractorProtocol {
    // MARK: -Conctsants
    enum Constants {
        static let wishesKey: String = "wishes"
    }
    
    // MARK: - Fields
    private let presenter: WishStoringPresenterProtocol
    
    // Core data properties
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let defaults: UserDefaults = UserDefaults.standard
    
    private var wishes: [Wish] = []
    
    // MARK: - Lifecycle methods
    init(presenter: WishStoringPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - Business Logic
    func loadStart(_ request: Model.Start.Request) {
        //wishes = defaults.array(forKey: Constants.wishesKey) as? [Wish] ?? []
        getAllWishes()
        presenter.presentStart(Model.Start.Response(wishes: wishes))
    }
    
    // Adds new wish to wishes
    func addWish(_ request: Model.AddWish.Request) {
        //let wish = request.wishText
        
        // Initializing new wish
        let wish = Wish(context: context)
        wish.wishText = request.wishText
        
        saveContext()
        
        //wishes.append(wish)
        //updateDefaults()
    }
    
    // Deletes wish from wishes
    func deleteWish(_ request: Model.DeleteWish.Request) {
        //wishes.remove(at: request.indexPath.row)
        //updateDefaults()
        
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
        // wishes[request.indexPath.row] = request.newWishText
        presenter.presentSendWish(Model.SendWish.Response(indexPath: request.indexPath))
    }
    
    // Updates wishes to current ones
    func loadWishes(_ request: Model.Fetch.Request) {
        let newIndexPath = IndexPath(row: wishes.count - 1, section: 1)
        getAllWishes()
        
        presenter.presentLoadWishes(Model.Fetch.Response(wishes: wishes, indexPath: newIndexPath))
    }
    
    // MARK: - Util functions
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
            fatalError()
        }
    }
    
    private func updateDefaults() {
        defaults.set(wishes, forKey: Constants.wishesKey)
    }
}
