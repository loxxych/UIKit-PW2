//
//  WishEventCreationAssembly.swift
//  aibednovaPW2
//
//  Created by loxxy on 16.01.2026.
//

import UIKit

enum WishEventCreationAssembly {
    static func build(updateCalendarEvents: (() -> Void)?) -> UIViewController {
        let presenter: WishEventCreationPresenter = WishEventCreationPresenter()
        let interactor: WishEventCreationInteractor = WishEventCreationInteractor(presenter: presenter)
        let viewController: WishEventCreationViewController = WishEventCreationViewController(
            interactor: interactor
        )
        
        // for updating events after adding them in the event creation screen
        interactor.updateCalendarEvents = updateCalendarEvents
        
        presenter.view = viewController
        
        return viewController
    }
}
