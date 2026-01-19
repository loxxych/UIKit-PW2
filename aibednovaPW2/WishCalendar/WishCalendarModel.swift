//
//  WishCalendarModel.swift
//  aibednovaPW2
//
//  Created by loxxy on 15.01.2026.
//

import UIKit

enum WishCalendarModel {
    enum Start {
        struct Response {
            let events: [WishEvent]
        }
        
        struct ViewModel {
            let wishes: [WishEventModel]
        }
    }
    
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
    
    enum ShowWishEventCreationViewController {
        struct Request {
            let updateCalendarEvents: (() -> Void)?
        }
        
        struct Response {
            let updateCalendarEvents: (() -> Void)?
        }
    }
}
