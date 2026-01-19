//
//  WishEventCreationModel.swift
//  aibednovaPW2
//
//  Created by loxxy on 16.01.2026.
//

import Foundation

enum WishEventCreationModel {
    enum AddWishEvent {
        struct Request {
            let wishEvent: WishEventModel
            
            init(wishEvent: WishEventModel) {
                self.wishEvent = wishEvent
            }
        }
    }
}
