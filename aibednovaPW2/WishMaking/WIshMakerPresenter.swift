//
//  WIshMakerPresenter.swift
//  aibednovaPW2
//
//  Created by loxxy on 08.11.2025.
//

final class WishMakerPresenter : WishMakerPresentationLogic {
    // MARK: - Constants
    enum Constants {
        // Strings
        static let showSliders: String = "Show sliders"
        static let hideSliders: String = "Hide sliders"
    }
    
    // MARK: - Fields
    weak var view: WishMakerViewController?
    
    // MARK: - Presentation logic
    func presentStart(_ response: Model.Start.Response) {
        let red = response.red
        let green = response.green
        let blue = response.blue
        view?.displayStart(Model.Start.ViewModel(red: red, green: green, blue: blue))
    }
    
    func presentColorUpdate(_ response: Model.ColorUpdate.Response) {
        view?.displayColorUpdate(Model.ColorUpdate.ViewModel(
            red: response.red,
            green: response.green,
            blue: response.blue
        ))
    }
    
    func presentToggleSliders(_ response: Model.ToggleSliders.Response) {
        let buttonTitle = response.isHidden ? Constants.showSliders : Constants.hideSliders
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
    
    func presentCalendarViewController(_ response: Model.ShowCalendarViewController.Response) {
        let vc = response.calendarViewController
        let nc = view?.navigationController
        nc?.pushViewController(vc, animated: true)
    }
}
