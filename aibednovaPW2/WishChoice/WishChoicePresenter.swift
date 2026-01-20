//
//  WishChoicePresenter.swift
//  aibednovaPW2
//
//  Created by loxxy on 20.01.2026.
//

final class WishChoicePresenter : WishChoicePresentationLogic {
    // MARK: - Constants
    private enum Constants {
    }
    
    // MARK: - Fields
    weak var view: WishChoiceViewController?
    
    // MARK: - Presentation logic
    func presentLoadWishes(_ response: Model.Fetch.Response) {
        view?.loadWishes(Model.Fetch.ViewModel(wishes: response.wishes, indexPath: response.indexPath))
    }

}
