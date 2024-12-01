//
//  SideMenuViewModel.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 29/11/2024.
//

import Foundation

enum SideMenuState {
    case loggedOut
}

final class SideMenuViewModel {
    private(set) var items = [SideMenuItem]()
    private(set) var currentState: SideMenuState = .loggedOut
    
    init() {
        updateItems(for: .loggedOut)
    }
    
    private func updateItems(for state: SideMenuState) {
        if state == .loggedOut {
            let loggedOutStrategy = LoggedOutStrategy()
            items = loggedOutStrategy.getSidemenuItems()
        }
    }
}
