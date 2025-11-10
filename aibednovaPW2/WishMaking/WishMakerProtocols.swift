//
//  WishMakerProtocols.swift
//  aibednovaPW2
//
//  Created by loxxy on 08.11.2025.
//

protocol WishMakerBusinessLogic {
    typealias Model = WishMakerModel
    func loadStart(_ request: Model.Start.Request)
    func updateColor(_ request: Model.ColorUpdate.Request)
    func toggleSliders(_ request: Model.ToggleSliders.Request)
    func generateRandomColor(_ request: Model.RandomColor.Request)
    func showAddWishViewController(_ request: Model.ShowAddWishViewController.Request)
}

protocol WishMakerPresentationLogic {
    typealias Model = WishMakerModel
    func presentStart(_ response: Model.Start.Response)
    func presentColorUpdate(_ response: Model.ColorUpdate.Response)
    func presentToggleSliders(_ response: Model.ToggleSliders.Response)
    func presentRandomColor(_ response: Model.RandomColor.Response)
    func presentAddWishViewController(_ response: Model.ShowAddWishViewController.Response)
}
