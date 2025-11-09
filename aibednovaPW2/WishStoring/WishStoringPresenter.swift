//
//  WishStoringPresenter.swift
//  aibednovaPW2
//
//  Created by loxxy on 08.11.2025.
//

final class WishStoringPresenter : WishStoringPresenterProtocol {
    typealias Model = WishStoringModel
    
    weak var view: WishStoringViewController?
    
    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(Model.Start.ViewModel(wishes: response.wishes))
    }
    
    func presentLoadWishes(_ response: Model.Fetch.Response) {
        view?.displayNewWish(Model.Fetch.ViewModel(wishes: response.wishes, indexPath: response.indexPath))
    }
    
    func presentEditWish(_ response: Model.EditWish.Response) {
        view?.displayCellEditMode(Model.EditWish.ViewModel(indexPath: response.indexPath))
    }
    
    func presentSendWish(_ response: Model.SendWish.Response) {
        view?.displayEndCellEditMode(Model.SendWish.ViewModel(indexPath: response.indexPath))
    }
}
