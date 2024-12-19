//
//  AbstractViewModel.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 05/12/2024.
//

import Foundation

final class AbstractViewModel: ViewModelProtocol {
    var selectedAppearance: AppearanceOption = .wallpaper
    var selectedFormat: Format = .randomTile
    
    weak var delegate: HomeViewModelProtocol?

    func updateSelectedAppearance(with state: AppearanceOption) {
        self.selectedAppearance = state
        self.delegate?.reloadMainCV?()
    }
    
    func getNumberOfItems() -> Int {
        15
    }
}
