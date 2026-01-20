//
//  WishCalendarPresenter.swift
//  aibednovaPW2
//
//  Created by loxxy on 15.01.2026.
//

import Foundation

final class WishCalendarPresenter : WishCalendarPresentationLogic {
    // MARK: - Fields
    weak var view: WishCalendarViewController?
    
    // MARK: - Presentation logic
    func presentLoadEvents(_ response: Model.Fetch.Response) {
        let events: [WishEventModel] = convertWishEventArray(response.events)
        
        
        view?.loadEvents(viewModel: Model.Fetch.ViewModel(events: events, indexPath: response.indexPath))
    }
    
    func presentWishEventCreationViewController(_ response: Model.ShowWishEventCreationViewController.Response) {
        let vc = WishEventCreationAssembly.build(updateCalendarEvents: response.updateCalendarEvents)
        
        view?.present(vc, animated: true)
    }
    
    // MARK: - Utility
    private func convertWishEventArray(_ eventsArray: [WishEvent]) -> [WishEventModel] {
        var events: [WishEventModel] = []
        
        for event in eventsArray {
            guard let title = event.title as String? else { continue }
            guard let description = event.eventDescription as String? else { continue }
            guard let startDate = event.startDate as Date?, let endDate = event.endDate as Date? else { continue }
            
            events.append(WishEventModel(title: title, description: description, startDate: startDate, endDate: endDate))
        }
        
        return events
    }
}
