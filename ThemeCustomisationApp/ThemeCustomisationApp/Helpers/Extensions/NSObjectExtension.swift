//
//  NSObjectExtension.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 22/11/2024.
//

import Foundation

extension NSObject {
    class var className: String {
        String(describing: self.self)
    }
}
