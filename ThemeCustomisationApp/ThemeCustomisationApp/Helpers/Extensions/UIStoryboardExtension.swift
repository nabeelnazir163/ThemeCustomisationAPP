//
//  UIStoryboardExtension.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 22/11/2024.
//

import UIKit

extension UIStoryboard {
    /// Use this func to get a controller from any storyboard
    ///
    /// Please note that Controller is a subclass of UIViewController and Storyboard an enum,
    /// please check Storyboard enum for all available Storyboards

    /// This method uses Controller: UIViewController as string identifier,
    /// if you want to get some controller with custom identifier please mention the identifier.
    class func instantiate<T: UIViewController>(storyboard: Storyboard) -> T? {
        let storyboard = UIStoryboard(name: storyboard.name, bundle: nil)
        return storyboard.instantiate(identifier: T.className) as? T
    }
    func instantiate<T: UIViewController>(identifier: String? = nil) -> T? {
        return instantiateViewController(withIdentifier: identifier.isSome ? identifier! : T
            .className) as? T
    }
    enum Storyboard: String {
        case main = "Main"
        case tutorial = "TutorialView"
        case sideMenu = "SideMenu"
        case help = "Help"
       
        var name: String {
            rawValue
        }
    }
}
