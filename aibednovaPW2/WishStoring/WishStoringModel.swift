//
//  WishStoringModel.swift
//  aibednovaPW2
//
//  Created by loxxy on 08.11.2025.
//

import UIKit

enum WishStoringModel {
    enum Start {
        struct Request { }
        struct Response {
            let wishes: [String]
        }
        struct ViewModel {
            let wishes: [String]
        }
    }
    
    enum AddWish {
        struct Request {
            let wishText: String
        }
    }
    
    enum DeleteWish {
        struct Request {
            let indexPath: IndexPath
        }
    }
    
    enum EditWish {
        struct Request {
            let indexPath: IndexPath
        }
        
        struct Response {
            let indexPath: IndexPath
        }
        
        struct ViewModel {
            let indexPath: IndexPath
        }
    }
    
    enum SendWish {
        struct Request {
            let indexPath: IndexPath
            let newWishText: String
        }
        
        struct Response {
            let indexPath: IndexPath
        }
        
        struct ViewModel {
            let indexPath: IndexPath
        }
    }
    
    enum Fetch {
        struct Request { }
        
        struct Response {
            let wishes: [String]
            let indexPath: IndexPath
        }
        
        struct ViewModel {
            let wishes: [String]
            let indexPath: IndexPath
        }
    }
}
