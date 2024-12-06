//
//  UIViewControllerExtension.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 06/12/2024.
//

import UIKit

extension UIViewController {
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(handleTapGesture))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTapGesture() {
        view.endEditing(true)
    }
}
