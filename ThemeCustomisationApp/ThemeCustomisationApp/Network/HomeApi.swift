//
//  HomeApi.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 19/12/2024.
//

import Foundation

class HomeApi: BaseApi {
    static func getWallpapers(pageNumber: Int? = 0, pageSize: Int = 10,
                              completion: @escaping APICompletion<WallPaperResponse>) {
        let call = HomeEndPoints.getWallpapers(pageNumber: pageNumber, pageSize: pageSize)
        performRequest(endpoint: call, completion: completion)
    }
    
    static func getCategories(completion: @escaping APICompletion<CategoriesResponse>) {
        let call = HomeEndPoints.getCategories
        performRequest(endpoint: call, completion: completion)
    }
}
