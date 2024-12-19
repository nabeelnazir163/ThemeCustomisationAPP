//
//  CategoriesResponse.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 19/12/2024.
//

import Foundation

struct CategoriesResponse: Codable {
    var categories: [CategoryItem]
}

struct CategoryItem: Codable {
    var id: Int
    var name: String
}
