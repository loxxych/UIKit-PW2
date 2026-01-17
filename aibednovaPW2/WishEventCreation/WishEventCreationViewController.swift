//
//  WishEventCreationViewController.swift
//  aibednovaPW2
//
//  Created by loxxy on 16.01.2026.
//

import UIKit

final class WishEventCreationViewController : UIViewController {
    // MARK: - Fields
    private var interactor: WishEventCreationBusinessLogic
    
    // MARK: - Lifecycle
    init(interactor: WishEventCreationBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
