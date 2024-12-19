//
//  WallPaper.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 19/12/2024.
//

import Foundation

struct WallPaperResponse: Codable {
    var pagination: Pagination
    var wallpapers: [WallPaper]
}

struct WallPaper: Codable {
    var id: Int
    var name: String
    var url: String
    var category_id: Int
    var total_likes: Int
    var total_saves: Int
}

struct Pagination: Codable {
    var currentPage: Int
    var totalPages: Int
}
