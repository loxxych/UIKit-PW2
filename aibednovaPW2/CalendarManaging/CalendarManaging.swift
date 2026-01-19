//
//  EventService.swift
//  aibednovaPW2
//
//  Created by loxxy on 20.01.2026.
//

import EventKit
protocol CalendarManaging {
    func create(eventModel: CalendarEventModel) -> Bool
}
