//
//  FilterTableViewCell.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 25/11/2024.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedIV: UIImageView!

    // MARK: - Life Cycle Methods
    func configureView(item: FilterView.FilterOption,
                       isSelected: Bool) {
        titleLabel.text = item.rawValue.capitalized
        selectedIV.isHidden = !isSelected
    }
}
