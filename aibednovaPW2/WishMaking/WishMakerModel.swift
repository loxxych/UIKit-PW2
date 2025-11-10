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
            let red: CGFloat?
            let green: CGFloat?
            let blue: CGFloat?
            let hex: String?
            
            init(red: CGFloat? = nil, green: CGFloat? = nil, blue: CGFloat? = nil, hex: String? = nil) {
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
}
