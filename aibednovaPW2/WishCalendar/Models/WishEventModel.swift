//
//  WishEventModel.swift
//  aibednovaPW2
//
//  Created by loxxy on 16.01.2026.
//

import Foundation

final class WishEventModel {
    var title: String
    var description: String
    var startDate: Date
    var endDate: Date
    
    init(title: String, description: String, startDate: Date, endDate: Date) {
        self.title = title
        self.description = description
        self.endDate = endDate
        self.startDate = startDate
    }
}
