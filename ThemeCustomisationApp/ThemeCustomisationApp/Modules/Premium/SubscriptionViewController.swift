//
//  SubscriptionViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 13/12/2024.
//

import UIKit

class SubscriptionViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var trialView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    // MARK: - Life Cycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        trialView.addGradient(colors: [.themePink.withAlphaComponent(0.3),
                                       .themeBlue.withAlphaComponent(0.3)])
        
        continueButton.addGradient()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapContinueButton(_ sender: Any) {
        Commons.shared.userState = .subscribed
        Commons.shared.navigateWindow(to: .home)
    }
    
    @IBAction func didTapSkipButton(_ sender: Any) {
        Commons.shared.userState = .loggedIn
        Commons.shared.navigateWindow(to: .home)
    }
    
}
