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
    
    func dismissUntilViewController(ofType targetType: AnyClass, animated: Bool, completion: (() -> Void)? = nil) {
        var currentVC: UIViewController? = self

        while let presentingVC = currentVC?.presentingViewController {
            if presentingVC.isKind(of: targetType) {
                presentingVC.dismiss(animated: animated, completion: completion)
                return
            }
            currentVC = presentingVC
        }
    }
}
