//
//  HomeViewModel.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 23/11/2024.
//

import Foundation
protocol HomeViewModelProtocol: AnyObject {
    func reloadCategories()
    func reloadMainCV()
}

class HomeViewModel {
    enum AppearanceOption: Int {
        case wallpaper = 0, icon, theme
    }
    
    enum Format: Int {
        case randomTile, grid
    }
    
    private(set) var categories = ["Top", "Tech", "Colors", "B&W", "Nature", "Others"]
    private(set) var selectedIndex = 0
    
    weak var delegate: HomeViewModelProtocol?
    
    private(set) var selectedAppearance: AppearanceOption = .wallpaper
    private(set) var selectedFormat: Format = .randomTile
    
    func updateSelectedIndex(with index: Int) {
        selectedIndex = index
        delegate?.reloadCategories()
    }
    
    func updateSelectedAppearance(with state: AppearanceOption) {
        self.selectedAppearance = state
    }
    
    func updateFormatStyle(with state: Format) {
        self.selectedFormat = state
        delegate?.reloadMainCV()
    }
}
