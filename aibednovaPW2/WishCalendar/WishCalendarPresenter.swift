//
//  WishCalendarPresenter.swift
//  aibednovaPW2
//
//  Created by loxxy on 15.01.2026.
//

class WishCalendarPresenter : WishCalendarPresentationLogic {
    weak var view: WishCalendarViewController?

    func presentWishEventCreationViewController(_ response: Model.ShowWishEventCreationViewController.Response) {
        
        view?.present(response.wishEventCreationViewController, animated: true)
    }
}
