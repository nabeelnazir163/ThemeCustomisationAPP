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
    
    private(set) var selectedIconIndeces: [Int] = []
    
    func updateType(for type: ThemeType) {
        self.selectedThemeType = type
    }
    
    func removeSelected(from index: Int) {
        selectedIconIndeces.remove(at: index)
    }
    
    func addToSelection(item: Int) {
        selectedIconIndeces.append(item)
    }
}
