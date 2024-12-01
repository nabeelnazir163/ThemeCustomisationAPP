//
//  PreviewThemeViewModel.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 01/12/2024.
//

import Foundation

final class PreviewThemeViewModel {
    enum ThemeType: Int {
        case wallpaper, icons
    }
    
    private(set) var selectedThemeType: ThemeType = .icons
    
    func updateType(for type: ThemeType) {
        self.selectedThemeType = type
    }
}
