//
//  WishMakerAssembly.swift
//  aibednovaPW2
//
//  Created by loxxy on 08.11.2025.
//

import UIKit

enum WishMakerAssembly {
    static func build() -> UIViewController {
        let presenter: WishMakerPresenter = WishMakerPresenter()
        let interactor: WishMakerInteractor = WishMakerInteractor(presenter: presenter)
        let viewController: WishMakerViewController = WishMakerViewController(
            interactor: interactor
        )
        
        presenter.view = viewController
        
        return viewController
    }
}
