//
//  FavouritesViewModel.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 28/11/2024.
//

import Foundation

final class FavouritesViewModel: ViewModelProtocol {
    var selectedAppearance: AppearanceOption = .wallpaper
    var selectedFormat: Format = .randomTile
    
    weak var delegate: HomeViewModelProtocol?

    func updateSelectedAppearance(with state: AppearanceOption) {
        self.selectedAppearance = state
        self.delegate?.reloadMainCV()
    }
}
