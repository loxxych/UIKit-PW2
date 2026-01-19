//
//  WishCalendarInteractor.swift
//  aibednovaPW2
//
//  Created by loxxy on 15.01.2026.
//

class WishCalendarInteractor : WishCalendarBusinessLogic {
    // MARK: - Fields
    private var presenter: WishCalendarPresentationLogic

    // MARK: - Lifecycle
    init(presenter: WishCalendarPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Business logic
    func showWishEventCreationViewController(_ request: Model.ShowWishEventCreationViewController.Request) {
        let vc = WishEventCreationAssembly.build()
        
        presenter.presentWishEventCreationViewController(Model.ShowWishEventCreationViewController.Response(wishEventCreationViewController: vc))
    }
}
