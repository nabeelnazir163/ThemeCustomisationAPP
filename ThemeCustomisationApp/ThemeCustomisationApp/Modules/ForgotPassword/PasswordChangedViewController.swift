//
//  PasswordChangedViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 06/12/2024.
//

import UIKit

class PasswordChangedViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!

    // MARK: - Life Cycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loginButton.addGradient()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.titleLabel?.font = UIFont.SFProBold(with: 20)
        setupHeadings()
    }
    
    private func setupHeadings() {
        titleLabel.font = UIFont.SFProBold(with: 24)
        subTitleLabel.font = UIFont.SFProRegular(with: 16)
    }
    
    // MARK: - Actions
    @IBAction func didTapBackButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        dismissUntilViewController(ofType: LoginViewController.self, animated: false)
    }
}
