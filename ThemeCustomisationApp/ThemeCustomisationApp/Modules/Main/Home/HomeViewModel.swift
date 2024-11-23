//
//  HomeViewModel.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 23/11/2024.
//

import Foundation
protocol HomeViewModelProtocol: AnyObject {
    func reloadCategories()
}

class HomeViewModel {
    private(set) var categories = ["Top", "Tech", "Colors", "B&W", "Nature", "Others"]
    private(set) var selectedIndex = 0
    
    weak var delegate: HomeViewModelProtocol?
    
    func updateSelectedIndex(with index: Int) {
        selectedIndex = index
        delegate?.reloadCategories()
    }
}
