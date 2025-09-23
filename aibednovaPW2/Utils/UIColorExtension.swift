//
//  UIColorExtension.swift
//  aibednovaPW1
//
//  Created by loxxy on 16.09.2025.
//

import UIKit

// MARK: UIColor class extension for converting hex to UIColor
extension UIColor {
    
    // MARK: contsants for hex to UIColor conversion
    private enum hexConstants {
        static let maxColorValue: CGFloat = 255
                
        // bit masks for each color
        static let redMask: UInt64 = 0xFF0000
        static let greenMask: UInt64 = 0x00FF00
        static let blueMask: UInt64 = 0x0000FF
                
        // bit shift for each color
        static let redShift: Int = 16
        static let greenShift: Int = 8
        static let blueShift: Int = 0
    }
    
    convenience init(hex: String) {
        // clear input of spaces, etc.
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        // remove "#"
        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }
        
        // convert hex to decimal
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        // extract color parts from input hex value
        let red = CGFloat((rgbValue & hexConstants.redMask) >> hexConstants.redShift) / hexConstants.maxColorValue
        let green = CGFloat((rgbValue & hexConstants.greenMask) >> hexConstants.greenShift) / hexConstants.maxColorValue
        let blue = CGFloat((rgbValue & hexConstants.blueMask) >> hexConstants.blueShift) / hexConstants.maxColorValue
        
        // initialize UIColor with extracted color values
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
