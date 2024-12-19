//
//  HomeEndPoints.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 19/12/2024.
//

import Foundation
import Alamofire

enum HomeEndPoints: APIConfiguration {
    case getWallpapers(pageNumber: Int?, pageSize: Int)
    case getCategories
    
    var method: HTTPMethod {
        switch self {
        case .getWallpapers, .getCategories:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getWallpapers(let page, let pageSize):
            return "api/wallpapers?page=\(page ?? 0)&page_size=\(pageSize)"
        case .getCategories:
            return "api/categories"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getWallpapers, .getCategories:
            return nil
        }
    }
    
    var headers: HTTPHeaders? {
        let headerDict: HTTPHeaders = self.getDefaultHeaders()
        switch self {
        case .getWallpapers, .getCategories:
            return headerDict
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var completeURL = Constants.Server.BASEURL + path
        var urlRequest = URLRequest(url: URL(string: completeURL)!)
        urlRequest.httpMethod = method.rawValue
        if let httpHeaders = headers {
            for aHeader in httpHeaders {
                urlRequest.headers.add(aHeader)
            }
        }
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}
