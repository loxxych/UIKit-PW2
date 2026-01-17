//
//  WishEventCreationAssembly.swift
//  aibednovaPW2
//
//  Created by loxxy on 16.01.2026.
//

import UIKit

enum WishEventCreationAssembly {
    static func build() -> UIViewController {
        let presenter: WishEventCreationPresenter = WishEventCreationPresenter()
        let interactor: WishEventCreationInteractor = WishEventCreationInteractor(presenter: presenter)
        let viewController: WishEventCreationViewController = WishEventCreationViewController(
            interactor: interactor
        )
        
        presenter.view = viewController
        
        return viewController
    }
}
