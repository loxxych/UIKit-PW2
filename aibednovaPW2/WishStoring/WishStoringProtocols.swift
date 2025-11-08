//
//  WishStoringProtocols.swift
//  aibednovaPW2
//
//  Created by loxxy on 08.11.2025.
//

protocol WishStoringInteractorProtocol {
    typealias Model = WishStoringModel
    
    func loadStart(_ request: Model.Start.Request)
    func addWish(_ request: Model.AddWish.Request)
    func loadWishes(_ request: Model.Fetch.Request)
}

protocol WishStoringPresenterProtocol {
    typealias Model = WishStoringModel
    
    func presentStart(_ response: Model.Start.Response)
    func presentLoadWishes(_ response: Model.Fetch.Response)
}
