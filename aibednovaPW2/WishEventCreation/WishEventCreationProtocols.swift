//
//  WishEventCreationProtocols.swift
//  aibednovaPW2
//
//  Created by loxxy on 16.01.2026.
//

protocol WishEventCreationBusinessLogic {
    typealias Model = WishEventCreationModel
    
    func addWish(_ request: Model.AddWishEvent.Request)
    func showChooseWishViewController()
}

protocol WishEventCreationPresentationLogic {
    typealias Model = WishEventCreationModel
    
    func presentCalendarCreationResult(_ response: Model.CalendarCreation.Response)
    func showChooseWishViewController()
}
