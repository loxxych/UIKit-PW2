//
//  WishCalendarModel.swift
//  aibednovaPW2
//
//  Created by loxxy on 15.01.2026.
//

import UIKit

enum WishCalendarModel {
    enum ShowWishEventCreationViewController {
        struct Request { }
        
        struct Response {
            let wishEventCreationViewController: UIViewController
            
            init(wishEventCreationViewController: UIViewController) {
                self.wishEventCreationViewController = wishEventCreationViewController
            }
        }
    }
}
