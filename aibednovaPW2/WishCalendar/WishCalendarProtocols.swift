//
//  WishCalendarProtocols.swift
//  aibednovaPW2
//
//  Created by loxxy on 15.01.2026.
//

protocol WishCalendarBusinessLogic {
    typealias Model = WishCalendarModel

    func showWishEventCreationViewController(_ request: Model.ShowWishEventCreationViewController.Request)
}

protocol WishCalendarPresentationLogic {
    typealias Model = WishCalendarModel
    
    func presentWishEventCreationViewController(_ response: Model.ShowWishEventCreationViewController.Response)
}
