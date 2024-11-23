//
//  Commons.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 22/11/2024.
//

import Foundation
import UIKit

final class Commons {
    enum RootWindow {
        case tutorial, home
    }
    
    static let shared = Commons()
    @UserDefaultStorage(key: Constants.UserDefaultConstants.isFirstLogin,
                        defaultValue: true)
    var isFirstLaunch: Bool
    
    private init() { }

    func navigateWindow(to view: RootWindow) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            switch view {
            case .tutorial:
                navigateToTutorials()
            case .home:
                navigateToHome()
            }
        }
    }
    
    private func navigateToTutorials() {
        guard let vc: TutorialsViewController = UIStoryboard.instantiate(storyboard: .tutorial) else { return }
        vc.viewModel = TutorialsViewModel()
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    private func navigateToHome() {
        guard let vc: CustomTabBarController = UIStoryboard.instantiate(storyboard: .main) else { return }
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
