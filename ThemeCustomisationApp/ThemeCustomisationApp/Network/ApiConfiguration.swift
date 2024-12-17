//
//  ApiConfiguration.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 17/12/2024.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
}

extension APIConfiguration {
    func getDefaultHeaders() -> HTTPHeaders {
        return HeadersUtility.createDefaultHeaders()
    }

}

struct HeadersUtility {
    static func createDefaultHeaders() -> HTTPHeaders {
        var headerDict: HTTPHeaders = HTTPHeaders()
        return headerDict
    }
    static func getDefaultHeadersAsDict() -> [String: String] {
        var dict = [String: String]()
        let defualtHeaders = HeadersUtility.createDefaultHeaders()
        for header in defualtHeaders {
            dict[header.name] = header.value
        }
        return dict
    }
}
