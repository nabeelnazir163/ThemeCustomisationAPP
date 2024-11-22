//
//  OptionalExtension.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 22/11/2024.
//

import Foundation

extension Optional {
    var isNone: Bool {
        self == nil
    }
    var isSome: Bool {
        self != nil
    }
}
