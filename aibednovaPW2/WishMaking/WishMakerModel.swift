//
//  WishMakerModel.swift
//  aibednovaPW2
//
//  Created by loxxy on 08.11.2025.
//
import UIKit

enum WishMakerModel {
    enum Start {
        struct Request { }
        
        struct Response {
            let red: CGFloat
            let green: CGFloat
            let blue: CGFloat
        }
        
        struct ViewModel {
            let red: CGFloat
            let green: CGFloat
            let blue: CGFloat
        }
    }
    
    enum ColorUpdate {
        struct Request {
            let red: Double?
            let green: Double?
            let blue: Double?
            let hex: String?
            
            init(red: Double? = nil, green: Double? = nil, blue: Double? = nil, hex: String? = nil) {
                self.red = red
                self.green = green
                self.blue = blue
                self.hex = hex
            }
        }
        
        struct Response {
            let red: CGFloat
            let green: CGFloat
            let blue: CGFloat
        }
        
        struct ViewModel {
            let red: CGFloat
            let green: CGFloat
            let blue: CGFloat
        }
    }
    
    enum ToggleSliders {
        struct Request { }
        
        struct Response {
            let isHidden: Bool
        }
        
        struct ViewModel {
            let isHidden: Bool
            let buttonTitle: String
        }
    }
    
    enum RandomColor {
        struct Request { }
        
        struct Response {
            let red: CGFloat
            let green: CGFloat
            let blue: CGFloat
        }
        
        struct ViewModel {
            let red: CGFloat
            let green: CGFloat
            let blue: CGFloat
        }
    }
    
    enum ShowAddWishViewController {
        struct Request { }
        
        struct Response {
            let wishStoringViewController: UIViewController
        }
    }
    
    enum ShowCalendarViewController {
        struct Request { }
        
        struct Response {
            let calendarViewController: UIViewController
        }
    }
}
