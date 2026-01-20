//
//  WishEventCreationPresenter.swift
//  aibednovaPW2
//
//  Created by loxxy on 16.01.2026.
//

import UIKit

class WishEventCreationPresenter : WishEventCreationPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        // Strings
        static let errorTitle = "Error"
        static let errorMessage = "Failed to add event"
        static let successTitle = "Success"
        static let okButtonTitle = "OK"
        static let eventAddedToCalendarMessage = "Event added to Calendar"
    }
    weak var view: WishEventCreationViewController?
    
    func presentCalendarCreationResult(_ response: Model.CalendarCreation.Response) {
        let success = response.success
        
        let alert = UIAlertController(title: success ? Constants.successTitle : Constants.errorTitle,
                                      message: success ? Constants.eventAddedToCalendarMessage : Constants.errorMessage,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.okButtonTitle, style: .default))
        
        view?.present(alert, animated: true)
    }
    
    func showChooseWishViewController() {
        let vc = WishChoiceAssembly.build(wishSelected: {[weak self] wishText in
            self?.view?.updateTitleInput(newTitle: wishText)
        })
        
        view?.present(vc, animated: true)
    }
}
