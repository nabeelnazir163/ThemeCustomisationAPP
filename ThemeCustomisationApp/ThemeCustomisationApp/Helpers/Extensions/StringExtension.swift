//
//  StringExtension.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 06/12/2024.
//

import Foundation
extension String {
    /// Safely retrieves the character at the specified index.
    /// - Parameter index: The zero-based index of the character.
    /// - Returns: The character at the specified index, or `nil` if the index is out of bounds.
    func character(at index: Int) -> String? {
        guard index >= 0 && index < self.count else {
            return nil // Index out of bounds
        }
        let stringIndex = self.index(self.startIndex, offsetBy: index)
        return String(self[stringIndex])
    }
}
