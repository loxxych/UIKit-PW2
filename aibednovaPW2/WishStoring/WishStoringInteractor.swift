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
    
    private let defaults: UserDefaults = UserDefaults.standard
    
    private var wishes: [String] = []
    
    // MARK: - Lifecycle methods
    init(presenter: WishStoringPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - Business Logic
    func loadStart(_ request: Model.Start.Request) {
        wishes = defaults.array(forKey: Constants.wishesKey) as? [String] ?? []
        presenter.presentStart(Model.Start.Response(wishes: wishes))
    }
    
    func addWish(_ request: Model.AddWish.Request) {
        let wish = request.wishText
        wishes.append(wish)
        updateDefaults()
    }
    
    func deleteWish(_ request: Model.DeleteWish.Request) {
        wishes.remove(at: request.indexPath.row)
        updateDefaults()
    }
    
    func editWish(_ request: Model.EditWish.Request) {
        presenter.presentEditWish(Model.EditWish.Response(indexPath: request.indexPath))
    }
    
    func sendWish(_ request: Model.SendWish.Request) {
        wishes[request.indexPath.row] = request.newWishText
        presenter.presentSendWish(Model.SendWish.Response(indexPath: request.indexPath))
    }
    
    func loadWishes(_ request: Model.Fetch.Request) {
        let newIndexPath = IndexPath(row: wishes.count - 1, section: 1)
        
        presenter.presentLoadWishes(Model.Fetch.Response(wishes: wishes, indexPath: newIndexPath))
    }
    
    // MARK: - Util functions
    private func updateDefaults() {
        defaults.set(wishes, forKey: Constants.wishesKey)
    }
}
