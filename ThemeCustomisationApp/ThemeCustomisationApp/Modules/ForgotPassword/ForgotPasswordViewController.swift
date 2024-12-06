//
//  ForgotPasswordViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 06/12/2024.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var sendCodeButton: UIButton!
    
    // MARK: - Life Cycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sendCodeButton.addGradient()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        sendCodeButton.titleLabel?.font = UIFont.SFProBold(with: 20)
        
        setupTextFields()
        setupHeadings()
    }
    
    private func setupTextFields() {
        emailTF.delegate = self
        emailTF.returnKeyType = .done
        emailTF.font = UIFont.SFProRegular(with: 16)
        emailTF.keyboardType = .emailAddress
        emailTF.superview?.superview?.updateState(to: false)
    }
    
    private func setupHeadings() {
        titleLabel.font = UIFont.SFProBold(with: 24)
        subTitleLabel.font = UIFont.SFProRegular(with: 16)
    }
    
    // MARK: - Actions
    @IBAction func didTapLoginButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapSendCode(_ sender: UIButton) {
        guard let vc: OTPVerficationViewController = UIStoryboard.instantiate(storyboard: .forgotPassword) else { return }
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.viewModel = OTPVerificationViewModel()
        present(vc, animated: true)
    }
}

// MARK: - TextField Delegate
extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.superview?.superview?.updateState(to: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.superview?.superview?.updateState(to: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
