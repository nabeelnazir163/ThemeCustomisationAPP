//
//  SearchViewModel.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 25/11/2024.
//

import Foundation

final class SearchViewModel {
    enum SearchType: Int {
        case wallpapers = 0, categories, icons, themes
    }
    
    private(set) var selectedType = SearchType.wallpapers
    
    func updateType(for type: SearchType) {
        self.selectedType = type
    }
}
