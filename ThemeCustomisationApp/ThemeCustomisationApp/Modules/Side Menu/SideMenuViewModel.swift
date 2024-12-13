//
//  SideMenuViewModel.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 29/11/2024.
//

import Foundation

final class SideMenuViewModel {
    private(set) var items = [SideMenuItem]()
    
    var accessTitleLabel: String {
        if Commons.shared.userState == .subscribed {
            return "Premium"
        } else {
            return "Get Access"
        }
    }
    
    var accessButtonTitle: String {
        if Commons.shared.userState == .subscribed {
            return "Go"
        } else {
            return "Get"
        }
    }
    
    init() {
        updateItems()
    }
    
    private func updateItems() {
        if Commons.shared.userState == .loggedOut {
            let loggedOutStrategy = LoggedOutStrategy()
            items = loggedOutStrategy.getSidemenuItems()
        } else {
            let loggedInStrategy = LoggedInStrategy()
            items = loggedInStrategy.getSidemenuItems()
        }
    }
}
