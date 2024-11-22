//
//  TutorialsCollectionViewCell.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 22/11/2024.
//

import UIKit

class TutorialsCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var stepper: [UIView]!
    
    var item: Tutorial? {
        didSet {
            imageView.image = item?.image
            titleLabel.text = item?.title
            descriptionLabel.text = item?.description
            
            stepper.forEach { view in
                view.borderColor = .white
            }
            stepper[item?.state.rawValue ?? 0].borderColor = .primaryText
        }
    }
}
