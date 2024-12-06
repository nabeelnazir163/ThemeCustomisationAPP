//
//  UIButtonExtension.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 06/12/2024.
//

import UIKit

extension UIButton {
    var isButtonEnabled: Bool {
        get {
            isUserInteractionEnabled
        } set {
            if newValue {
                isUserInteractionEnabled = true
                addGradient()
                borderWidth = 0
            } else {
                isUserInteractionEnabled = false
                removeGradientLayer()
                backgroundColor = UIColor.themePink.withAlphaComponent(0.06)
                borderWidth = 1
                borderColor = .border
            }
        }
    }
}
