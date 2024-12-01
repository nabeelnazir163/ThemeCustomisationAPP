//
//  SideMenuStrategies.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 29/11/2024.
//

import UIKit

enum SideMenuItemType {
    case details, `switch`
}

enum SideMenu: String {
    case notification = "Notification"
    case privacyPolicy = "Privacy & Policy"
    case aboutUs = "About Us"
    case helpCenter = "Help Center"
}

struct SideMenuItem {
    let icon: UIImage
    let item: SideMenu
    let type: SideMenuItemType
}

protocol SideMenuStrategies {
    func getSidemenuItems() -> [SideMenuItem]
}

final class LoggedOutStrategy: SideMenuStrategies {
    func getSidemenuItems() -> [SideMenuItem] {
        [
            SideMenuItem(icon: .sideMenuNotification, item: .notification, type: .switch),
            SideMenuItem(icon: .sideMenuPrivacyPolicy, item: .privacyPolicy, type: .details),
            SideMenuItem(icon: .sideMenuAboutUs, item: .aboutUs, type: .details),
            SideMenuItem(icon: .sideMenuHelpCenter, item: .helpCenter, type: .details)
        ]
    }
}