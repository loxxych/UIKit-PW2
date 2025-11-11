//
//  WishStoringAssembly.swift
//  aibednovaPW2
//
//  Created by loxxy on 08.11.2025.
//

import UIKit

enum WishStoringAssembly {
    static func build() -> UIViewController {
        let presenter: WishStoringPresenter = WishStoringPresenter()
        let interactor: WishStoringInteractor = WishStoringInteractor(presenter: presenter)
        let viewController: WishStoringViewController = WishStoringViewController(
            interactor: interactor
        )
        
        presenter.view = viewController
        
        return viewController
    }
}
