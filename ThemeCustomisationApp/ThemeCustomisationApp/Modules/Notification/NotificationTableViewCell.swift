//
//  NotificationTableViewCell.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 03/12/2024.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configureView() {
        mainView.addDropShadow(color: .appGray.withAlphaComponent(0.5))
        titleLabel.font = UIFont.SFProBold(with: 16)
        descriptionLabel.font = UIFont.SFProRegular(with: 14)
    }
}
