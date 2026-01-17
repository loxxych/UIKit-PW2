//
//  WishCalendarInteractor.swift
//  aibednovaPW2
//
//  Created by loxxy on 15.01.2026.
//

class WishCalendarInteractor : WishCalendarBusinessLogic {
    private var presenter: WishCalendarPresentationLogic

    init(presenter: WishCalendarPresentationLogic) {
        self.presenter = presenter
    }
}
