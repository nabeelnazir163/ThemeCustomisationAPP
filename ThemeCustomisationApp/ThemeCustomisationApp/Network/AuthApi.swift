//
//  AuthApi.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 17/12/2024.
//

import Foundation

class AuthAPI: BaseApi {
    static func login(email: String, password: String, completion: @escaping APICompletion<LoginResponse>) {
        let call = AuthEndpoint.login(email: email, password: password)
        performRequest(endpoint: call, completion: completion)
    }
}
