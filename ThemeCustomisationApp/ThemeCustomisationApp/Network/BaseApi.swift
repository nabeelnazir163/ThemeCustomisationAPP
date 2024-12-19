//
//  BaseApi.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 17/12/2024.
//

import Foundation
import Alamofire

struct APIResponse<T: Codable>: Codable {
    let data: T?
    let code: Int
}

typealias APICompletion<T: Codable> = (AFDataResponse<APIResponse<T>>) -> Void

class BaseApi {
    @discardableResult
    static func performRequest<T: Decodable>(endpoint: APIConfiguration,
                                             completion: @escaping (AFDataResponse<T>) -> Void) -> DataRequest {
        print(endpoint)
        return NetworkClient.request(endpoint: endpoint, completion: completion)
    }
}
