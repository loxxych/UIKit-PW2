//
//  WishChoiceModel.swift
//  aibednovaPW2
//
//  Created by loxxy on 20.01.2026.
//

import Foundation

enum WishChoiceModel {
    struct Fetch {
        struct Response {
            let wishes: [Wish]
            let indexPath: IndexPath
        }
        
        struct ViewModel {
            let wishes: [Wish]
            let indexPath: IndexPath
        }
    }
}
