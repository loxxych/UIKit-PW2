//
//  WishEventCreationInteractor.swift
//  aibednovaPW2
//
//  Created by loxxy on 16.01.2026.
//

class WishEventCreationInteractor : WishEventCreationBusinessLogic {
    private var presenter: WishEventCreationPresentationLogic
    
    init(presenter: WishEventCreationPresentationLogic) {
        self.presenter = presenter
    }
    
}
