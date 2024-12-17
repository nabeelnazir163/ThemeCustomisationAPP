//
//  AuthEndpoints.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 17/12/2024.
//

import Foundation
import Alamofire

enum AuthEndpoint: APIConfiguration {
    case login(email: String, password: String)
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/login"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            var param: [String: Any] = [:]
            param = [Constants.APIParameterKey.email: email,
                     Constants.APIParameterKey.password: password
                    ]
            return param
        }
    }
    
    var headers: HTTPHeaders? {
        var headerDict: HTTPHeaders = self.getDefaultHeaders()
        switch self {
        case .login:
            return headerDict
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var completeURL = ""
        switch self {
        case .login:
            completeURL = Constants.Server.BASEURL + path
        }
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
