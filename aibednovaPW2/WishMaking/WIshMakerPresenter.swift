//
//  WIshMakerPresenter.swift
//  aibednovaPW2
//
//  Created by loxxy on 08.11.2025.
//

final class WishMakerPresenter : WishMakerPresenterProtocol {
    weak var view: WishMakerViewController?

    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(Model.Start.ViewModel())
    }
    
    func presentColorUpdate(_ response: Model.ColorUpdate.Response) {
        view?.displayColorUpdate(Model.ColorUpdate.ViewModel(
                    red: response.red,
                    green: response.green,
                    blue: response.blue
                ))
    }
    
    func presentToggleSliders(_ response: Model.ToggleSliders.Response) {
        let buttonTitle = response.isHidden ? "Show sliders" : "Hide sliders"
                view?.displayToggleSliders(Model.ToggleSliders.ViewModel(
                    isHidden: response.isHidden,
                    buttonTitle: buttonTitle
                ))
    }
    
    func presentRandomColor(_ response: Model.RandomColor.Response) {
        view?.displayRandomColor(Model.RandomColor.ViewModel(
                    red: response.red,
                    green: response.green,
                    blue: response.blue
                ))
    }
    
    func presentAddWishViewController(_ response: Model.ShowAddWishViewController.Response) {
        view?.present(response.wishStoringViewController, animated: true)
    }
}
