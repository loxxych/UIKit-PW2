//
//  WishCalendarModel.swift
//  aibednovaPW2
//
//  Created by loxxy on 15.01.2026.
//

import UIKit

enum WishCalendarModel {
    enum Fetch {
        struct Response {
            let events: [WishEvent]
            let indexPath: IndexPath
        }
        
        struct ViewModel {
            let events: [WishEventModel]
            let indexPath: IndexPath
        }
    }
    
    enum Delete {
        struct Request {
            let event: WishEventModel
        }
    }
    
    enum ShowWishEventCreationViewController {
        struct Request {
            let updateCalendarEvents: (() -> Void)?
        }
        
        struct Response {
            let updateCalendarEvents: (() -> Void)?
        }
    }
}
