//
//  OnboardingViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 04/12/2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var continueWithButton: UIButton!
    
    // MARK: - Life Cycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        continueWithButton.addGradient(colors: [.themePink,
                                                .themeBlue])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Actions
    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapContinueButton(_ sender: Any) {
        guard let vc: RegisterViewController = UIStoryboard.instantiate(storyboard: .authentication) else { return }
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
}
