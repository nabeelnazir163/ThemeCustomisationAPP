//
//  Commons.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 22/11/2024.
//

import Lottie
import UIKit

final class Commons {
    enum RootWindow {
        case tutorial, home, onboarding
    }
    
    enum UserState {
        case loggedOut, loggedIn, subscribed
    }
    
    static let shared = Commons()
    @UserDefaultStorage(key: Constants.UserDefaultConstants.isFirstLogin,
                        defaultValue: true)
    var isFirstLaunch: Bool
    
    var userState = UserState.loggedOut
    
    private let ActivityViewTag = 121
    private let LoaderBGView = 122
    
    private var window: UIWindow? {
        UIApplication.shared.windows.first
    }
    
    private init() { }

    func navigateWindow(to view: RootWindow) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            switch view {
            case .tutorial:
                navigateToTutorials()
            case .home:
                navigateToHome()
            case .onboarding:
                navigateToOnboarding()
            }
        }
    }
    
    private func navigateToTutorials() {
        guard let vc: TutorialsViewController = UIStoryboard.instantiate(storyboard: .tutorial) else { return }
        vc.viewModel = TutorialsViewModel()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    private func navigateToHome() {
        guard let vc: CustomTabBarController = UIStoryboard.instantiate(storyboard: .main) else { return }
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    private func navigateToOnboarding() {
        guard let vc: ForgotPasswordViewController = UIStoryboard.instantiate(storyboard: .forgotPassword) else { return }
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    func showActivityIndicator() -> Void {
        let animationView: LottieAnimationView = .init(name: "Loader")
        animationView.tag = ActivityViewTag
        animationView.backgroundColor = .white
        animationView.cornerRadius = 12
        
        guard let window = window else { return }
        let BGView = UIView()
        BGView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        BGView.tag = LoaderBGView
        BGView.frame = window.frame
        if let bgView = window.viewWithTag(LoaderBGView) {
            bgView.removeFromSuperview()
        }
        
        if let activityView = window.viewWithTag(ActivityViewTag) {
            activityView.removeFromSuperview()
        }
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        
        window.addSubview(BGView)
        
        window.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        animationView.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
        animationView.play()
    }

    func hideActivityIndicator() -> Void {
        guard let window = window else { return }
        if let activityView = window.viewWithTag(ActivityViewTag){
            activityView.removeFromSuperview()
        }
        
        if let bgView = window.viewWithTag(LoaderBGView) {
            bgView.removeFromSuperview()
        }
    }
    
    func showAlert(title: String = "Theme Saver", msg: String)  {
        window?.endEditing(true)
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
