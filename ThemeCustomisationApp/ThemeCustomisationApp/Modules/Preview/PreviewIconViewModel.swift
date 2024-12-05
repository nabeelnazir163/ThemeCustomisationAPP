//
//  PreviewIconViewModel.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 05/12/2024.
//

import Foundation
final class PreviewIconViewModel {
    private(set) var selectedIconIndeces: [Int] = []
    
    func removeSelected(from index: Int) {
        selectedIconIndeces.remove(at: index)
    }
    
    func addToSelection(item: Int) {
        selectedIconIndeces.append(item)
    }
}
