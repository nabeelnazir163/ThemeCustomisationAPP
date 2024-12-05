//
//  UIFontExtension.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 05/12/2024.
//

import UIKit

extension UIFont {
    static func SFProRegular(with size: CGFloat) -> UIFont? {
        UIFont(name: "SFProDisplay-Regular",
               size: size)
    }
    static func SFProMedium(with size: CGFloat) -> UIFont? {
        UIFont(name: "SFProDisplay-Medium",
               size: size)
    }
    static func SFProBold(with size: CGFloat) -> UIFont? {
        UIFont(name: "SFProDisplay-Bold",
               size: size)
    }
}
