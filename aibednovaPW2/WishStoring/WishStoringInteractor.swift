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
    
    init(presenter: WishStoringPresenterProtocol) {
        self.presenter = presenter
    }
    
    func loadStart(_ request: Model.Start.Request) {
        wishes = defaults.array(forKey: Constants.wishesKey) as? [String] ?? []
        presenter.presentStart(Model.Start.Response(wishes: wishes))
    }
    
    func addWish(_ request: Model.AddWish.Request) {
        let wish = request.wishText
        wishes.append(wish)
        
        defaults.set(wishes, forKey: Constants.wishesKey)
    }
    
    func loadWishes(_ request: Model.Fetch.Request) {
        let newIndexPath = IndexPath(row: wishes.count - 1, section: 1)
        
        presenter.presentLoadWishes(Model.Fetch.Response(wishes: wishes, indexPath: newIndexPath))
    }
}
