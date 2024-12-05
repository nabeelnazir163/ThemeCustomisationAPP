//
//  SingleIconCollectionViewCell.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 05/12/2024.
//

import UIKit

class SingleIconCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var selectedIcon: UIImageView!
    
    func configureCell(isSelected: Bool) {
        selectedIcon.image = UIImage(resource: isSelected ? .selectedIcon : .unSelectedCircleIcon)
    }
}
