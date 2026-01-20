//
//  WIshChoiceAssembly.swift
//  aibednovaPW2
//
//  Created by loxxy on 20.01.2026.
//

import UIKit

enum WishChoiceAssembly {
    static func build() -> UIViewController {
        let presenter: WishChoicePresenter = WishChoicePresenter()
        let interactor: WishChoiceInteractor = WishChoiceInteractor(presenter: presenter)
        let viewController: WishChoiceViewController = WishChoiceViewController(
            interactor: interactor
        )
        
        presenter.view = viewController
        
        return viewController
    }
}
