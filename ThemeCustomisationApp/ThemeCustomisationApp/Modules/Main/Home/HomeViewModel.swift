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

enum AppearanceOption: Int {
    case wallpaper = 0, icon, theme
}

enum Format: Int {
    case randomTile, grid
}

class HomeViewModel: ViewModelProtocol {
    private(set) var categories = ["Top", "Tech", "Colors", "B&W", "Nature", "Others"]
    private(set) var selectedIndex = 0
    
    weak var delegate: HomeViewModelProtocol?
    
    var selectedAppearance: AppearanceOption = .wallpaper
    var selectedFormat: Format = .randomTile
    
    func updateSelectedIndex(with index: Int) {
        selectedIndex = index
        delegate?.reloadCategories()
    }
    
    func updateSelectedAppearance(with state: AppearanceOption) {
        self.selectedAppearance = state
        self.delegate?.reloadMainCV()
    }
    
    func updateFormatStyle(with state: Format) {
        self.selectedFormat = state
        delegate?.reloadMainCV()
    }
}
