//
//  HomeViewModel.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 23/11/2024.
//

import Foundation
@objc protocol HomeViewModelProtocol: AnyObject {
    @objc optional func reloadCategories()
    @objc optional func reloadMainCV()
}

enum AppearanceOption: Int {
    case wallpaper = 0, icon, theme
}

enum Format: Int {
    case randomTile, grid
}

class HomeViewModel: ViewModelProtocol {
    private(set) var selectedIndex = 0
    
    weak var delegate: HomeViewModelProtocol?
    
    var selectedAppearance: AppearanceOption = .wallpaper
    var selectedFormat: Format = .randomTile
    
    
    private(set) var wallPaperData: WallPaperResponse?
    private(set) var categories = [CategoryItem]()
    
    func onViewDidLoad() {
        fetchCategories()
    }
    
    private func fetchCategories() {
        Commons.shared.showActivityIndicator()
        HomeApi.getCategories { [weak self] afResponse in
            guard let self else { return }
            switch afResponse.result {
            case .success(let data):
                self.categories = data.data?.categories ?? []
                self.delegate?.reloadCategories?()
                Commons.shared.hideActivityIndicator()
//                fetchWallpapers()
            case .failure(let error):
                Commons.shared.hideActivityIndicator()
                Commons.shared.showAlert(msg: error.localizedDescription)
            }
        }
    }
    
    private func fetchWallpapers() {
        HomeApi.getWallpapers(pageNumber: 0) { [weak self] response in
            Commons.shared.hideActivityIndicator()
            guard let self else { return }
            switch response.result {
            case .success(let data):
                self.wallPaperData = data.data
                self.delegate?.reloadMainCV?()
            case .failure(let error):
                Commons.shared.showAlert(msg: error.localizedDescription)
            }
        }
    }
    
    func getNumberOfItems() -> Int {
        if selectedAppearance == .wallpaper {
            return wallPaperData?.wallpapers.count ?? 0
        }
        return 0
    }
    
    func updateSelectedIndex(with index: Int) {
        selectedIndex = index
        delegate?.reloadCategories?()
    }
    
    func updateSelectedAppearance(with state: AppearanceOption) {
        self.selectedAppearance = state
        self.delegate?.reloadMainCV?()
    }
    
    func updateFormatStyle(with state: Format) {
        self.selectedFormat = state
        delegate?.reloadMainCV?()
    }
}
