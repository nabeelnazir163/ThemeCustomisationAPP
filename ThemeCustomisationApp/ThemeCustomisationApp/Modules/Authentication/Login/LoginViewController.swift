//
//  LoginViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 05/12/2024.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Life Cycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loginButton.addGradient()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.titleLabel?.font = UIFont.SFProBold(with: 20)
        
        setupTextFields()
        setupHeadings()
    }
    
    private func setupTextFields() {
        emailTF.delegate = self
        passwordTF.delegate = self
        
        emailTF.returnKeyType = .next
        passwordTF.returnKeyType = .next
        
        emailTF.font = UIFont.SFProRegular(with: 16)
        passwordTF.font = UIFont.SFProRegular(with: 16)
        
        emailTF.keyboardType = .emailAddress
        passwordTF.keyboardType = .default
        
        passwordTF.isSecureTextEntry = true
        
        emailTF.superview?.superview?.updateState(to: false)
        passwordTF.superview?.superview?.updateState(to: false)
    }
    
    private func setupHeadings() {
        titleLabel.font = UIFont.SFProBold(with: 24)
        subTitleLabel.font = UIFont.SFProRegular(with: 16)
    }
    
    // MARK: - Actions
    @IBAction func didTapSeePassword(_ sender: UIButton) {
        passwordTF.isSecureTextEntry.toggle()
    }
    
    @IBAction func didTapSignupButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - TextField Delegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.superview?.superview?.updateState(to: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.superview?.superview?.updateState(to: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTF {
            passwordTF.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

