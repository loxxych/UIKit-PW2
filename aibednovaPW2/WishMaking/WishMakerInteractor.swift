//
//  WishMakerInteractor.swift
//  aibednovaPW2
//
//  Created by loxxy on 08.11.2025.
//

import UIKit

final class WishMakerInteractor : WishMakerBusinessLogic {
    // MARK: - Constants
    private enum Constants {
        static let minSliderValue: Double = 0
        static let maxSliderValue: Double = 1
        
        static let redInitValue: CGFloat = 0.5
        static let blueInitValue: CGFloat = 0.5
        static let greenInitValue: CGFloat = 0.5
        static let alpha: CGFloat = 1
    }
    
    // MARK: - Fields
    private var presenter: WishMakerPresentationLogic
    
    private var slidersHidden: Bool = false
    private var redValue: Double = Constants.redInitValue
    private var blueValue: Double = Constants.blueInitValue
    private var greenValue: Double = Constants.greenInitValue
    
    // MARK: - Lifecycle
    init(presenter: WishMakerPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Business logic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response(red: Constants.redInitValue, green: Constants.greenInitValue, blue: Constants.blueInitValue))
    }
    
    // Update background color
    func updateColor(_ request: Model.ColorUpdate.Request) {
        // Color is in hex
        if let hex = request.hex, !hex.isEmpty {
            let color = UIColor(hex: hex)
            var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
            color.getRed(&red, green: &green, blue: &blue, alpha: nil)
            
            redValue = Double(red)
            greenValue = Double(green)
            blueValue = Double(blue)
        } else { // Color in RGB
            // Use color values from request or current colors if request colors are nil
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
    
    // Switch slider visibility
    func toggleSliders(_ request: Model.ToggleSliders.Request) {
        slidersHidden.toggle()
        presenter.presentToggleSliders(Model.ToggleSliders.Response(
            isHidden: slidersHidden
        ))
    }
    
    // Shows the add wish screen
    func showAddWishViewController(_ request: Model.ShowAddWishViewController.Request) -> Void {
        let color = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: Constants.alpha)
        let wishStoringVC = WishStoringAssembly.build(color: color)
        
        presenter.presentAddWishViewController(Model.ShowAddWishViewController.Response(wishStoringViewController: wishStoringVC))
    }
    
    // Shows the wish calendar screen
    func showCalendarViewController(_ request: Model.ShowCalendarViewController.Request) -> Void {
        let color = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: Constants.alpha)
        let CalendarVC = WishCalendarAssembly.build(color: color)
        
        presenter.presentCalendarViewController(Model.ShowCalendarViewController.Response(calendarViewController: CalendarVC))
    }
    
    // Switches background color to a random color
    func generateRandomColor(_ request: Model.RandomColor.Request) {
        redValue = CGFloat.random(in: Constants.minSliderValue...Constants.maxSliderValue)
        blueValue = CGFloat.random(in: Constants.minSliderValue...Constants.maxSliderValue)
        greenValue = CGFloat.random(in: Constants.minSliderValue...Constants.maxSliderValue)
        
        presenter.presentRandomColor(Model.RandomColor.Response(
            red: redValue,
            green: blueValue,
            blue: greenValue
        ))
    }
    
}
