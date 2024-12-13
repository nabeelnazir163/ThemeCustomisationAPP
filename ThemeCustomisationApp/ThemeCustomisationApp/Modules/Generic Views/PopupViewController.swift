//
//  PopupViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 13/12/2024.
//

import UIKit

enum PopupType {
    case profileUpdate
    
    var backgroundImage: UIImage? {
        switch self {
        case .profileUpdate:
                .popper
        }
    }
    
    var mainImage: UIImage {
        switch self {
        case .profileUpdate:
                .profileConfirmation
        }
    }
    
    var title: String {
        switch self {
        case .profileUpdate:
            "Your Profile has been updated successfully"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .profileUpdate:
            "CONTINUE"
        }
    }
}

class PopupViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var BGImageView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    // MARK: - Properties
    var callback: (() -> Void)?
    var type: PopupType?

    // MARK: - Life Cycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        continueButton.addGradient()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        guard let type else { return }
        
        BGImageView.image = type.backgroundImage
        mainImageView.image = type.mainImage
        titleLabel.text = type.title
        continueButton.setTitle(type.buttonTitle, for: .normal)
    }
    
    // MARK: - Actions
    @IBAction func didTapContinueButton(_ sender: Any) {
        dismiss(animated: true, completion: callback)
    }
}
