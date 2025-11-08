//
//  WishMakerInteractor.swift
//  aibednovaPW2
//
//  Created by loxxy on 08.11.2025.
//

import UIKit

final class WishMakerInteractor : WishMakerInteractorProtocol {
    private var presenter: WishMakerPresenterProtocol
    
    private var slidersHidden: Bool = false
    private var redValue: Double = Constants.redInitValue
    private var blueValue: Double = Constants.blueInitValue
    private var greenValue: Double = Constants.greenInitValue
    
    // MARK: - Constants
    private enum Constants {
        static let minSliderValue: Double = 0
        static let maxSliderValue: Double = 1
        
        static let redInitValue: Double = 0.5
        static let blueInitValue: Double = 0.5
        static let greenInitValue: Double = 0.5
    }
    
    init(presenter: WishMakerPresenterProtocol) {
        self.presenter = presenter
    }
    
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
    
    func updateColor(_ request: Model.ColorUpdate.Request) {
        if let hex = request.hex, !hex.isEmpty {
            let color = UIColor(hex: hex)
            var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
            color.getRed(&red, green: &green, blue: &blue, alpha: nil)
            
            redValue = Double(red)
            greenValue = Double(green)
            blueValue = Double(blue)
        } else {
            // use color values from request or current if nil
            redValue = request.red ?? redValue
            greenValue = request.green ?? greenValue
            blueValue = request.blue ?? blueValue
        }
        presenter.presentColorUpdate(Model.ColorUpdate.Response(
            red: redValue,
            green: greenValue,
            blue: blueValue
        ))
    }
    
    func toggleSliders(_ request: Model.ToggleSliders.Request) {
        slidersHidden.toggle()
        presenter.presentToggleSliders(Model.ToggleSliders.Response(
            isHidden: slidersHidden
        ))
    }
    
    func showAddWishViewController(_ request: Model.ShowAddWishViewController.Request) -> Void {
        let wishStoringVC = WishStoringAssembly.build()
        
        presenter.presentAddWishViewController(Model.ShowAddWishViewController.Response(wishStoringViewController: wishStoringVC))
    }
    
    func calculateBackgroundColor(red: Double, green: Double, blue: Double) -> UIColor {
        return .init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
    }
    
    func generateRandomColor(_ request: Model.RandomColor.Request) {
        redValue = Double.random(in: Constants.minSliderValue...Constants.maxSliderValue)
        blueValue = Double.random(in: Constants.minSliderValue...Constants.maxSliderValue)
        greenValue = Double.random(in: Constants.minSliderValue...Constants.maxSliderValue)
        
        presenter.presentRandomColor(Model.RandomColor.Response(
                    red: redValue,
                    green: blueValue,
                    blue: greenValue
                ))
    }
    
}
