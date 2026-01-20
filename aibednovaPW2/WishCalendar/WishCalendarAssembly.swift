//
//  WishCalendarAssembly.swift
//  aibednovaPW2
//
//  Created by loxxy on 15.01.2026.
//

import UIKit

enum WishCalendarAssembly {
    static func build(color: UIColor) -> UIViewController {
        let presenter: WishCalendarPresenter = WishCalendarPresenter()
        let interactor: WishCalendarInteractor = WishCalendarInteractor(presenter: presenter)
        let viewController: WishCalendarViewController = WishCalendarViewController(
            interactor: interactor,
            bgColor: color
        )
        
        presenter.view = viewController
        
        return viewController
    }
}
