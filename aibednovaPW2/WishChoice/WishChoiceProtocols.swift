//
//  WishChoiceProtocols.swift
//  aibednovaPW2
//
//  Created by loxxy on 20.01.2026.
//

protocol WishChoiceBusinessLogic {
    typealias Model = WishChoiceModel

    func loadWishes()
}

protocol WishChoicePresentationLogic {
    typealias Model = WishChoiceModel
    
    func presentLoadWishes(_ response: Model.Fetch.Response)
}
