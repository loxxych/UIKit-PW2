//
//  WishEventModel.swift
//  aibednovaPW2
//
//  Created by loxxy on 16.01.2026.
//

class WishEventModel {
    var title: String
    var description: String
    var startDate: String
    var endDate: String
    
    init(title: String, description: String, startDate: String, endDate: String) {
        self.title = title
        self.description = description
        self.endDate = endDate
        self.startDate = startDate
    }
}
