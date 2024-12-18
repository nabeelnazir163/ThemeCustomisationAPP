//
//  LoginViewModel.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 19/12/2024.
//

import Foundation

final class LoginViewModel {
    func onLogin(with email: String, password: String) {
        AuthAPI.login(email: email, password: password) { afResponse in
            switch afResponse.result {
            case .success(let response):
                let loginResponse = response.data
                print(loginResponse?.token)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
