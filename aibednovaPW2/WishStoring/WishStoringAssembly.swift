//
//  WishStoringAssembly.swift
//  aibednovaPW2
//
//  Created by loxxy on 08.11.2025.
//

import UIKit

enum WishStoringAssembly {
    static func build(color: UIColor) -> UIViewController {
        let presenter: WishStoringPresenter = WishStoringPresenter()
        let interactor: WishStoringInteractor = WishStoringInteractor(presenter: presenter)
        let viewController: WishStoringViewController = WishStoringViewController(
            interactor: interactor,
            bgColor: color
        )
        
        presenter.view = viewController
        
        return viewController
    }
}
