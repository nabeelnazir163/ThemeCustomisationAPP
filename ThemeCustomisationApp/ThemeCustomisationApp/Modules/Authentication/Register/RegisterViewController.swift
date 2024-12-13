//
//  RegisterViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 05/12/2024.
//

import UIKit

class RegisterViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: - Life Cycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        registerButton.addGradient()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.titleLabel?.font = UIFont.SFProBold(with: 20)
        
        setupTextFields()
        setupHeadings()
    }
    
    private func setupTextFields() {
        usernameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        confirmPasswordTF.delegate = self
        
        usernameTF.returnKeyType = .next
        emailTF.returnKeyType = .next
        passwordTF.returnKeyType = .next
        confirmPasswordTF.returnKeyType = .done
        
        usernameTF.font = UIFont.SFProRegular(with: 16)
        emailTF.font = UIFont.SFProRegular(with: 16)
        passwordTF.font = UIFont.SFProRegular(with: 16)
        confirmPasswordTF.font = UIFont.SFProRegular(with: 16)
        
        usernameTF.keyboardType = .default
        emailTF.keyboardType = .emailAddress
        passwordTF.keyboardType = .default
        confirmPasswordTF.keyboardType = .default
        
        passwordTF.isSecureTextEntry = true
        confirmPasswordTF.isSecureTextEntry = true
        
        usernameTF.superview?.superview?.updateState(to: false)
        emailTF.superview?.superview?.updateState(to: false)
        passwordTF.superview?.superview?.updateState(to: false)
        confirmPasswordTF.superview?.superview?.updateState(to: false)
    }
    
    private func setupHeadings() {
        titleLabel.font = UIFont.SFProBold(with: 24)
        subTitleLabel.font = UIFont.SFProRegular(with: 16)
    }
    
    // MARK: - Actions
    @IBAction func didTapSeePassword(_ sender: UIButton) {
        passwordTF.isSecureTextEntry.toggle()
    }
    
    @IBAction func didTapSeeConfirmPassword(_ sender: Any) {
        confirmPasswordTF.isSecureTextEntry.toggle()
    }
    
    @IBAction func didTapSigninButton(_ sender: Any) {
        guard let vc: LoginViewController = UIStoryboard.instantiate(storyboard: .authentication) else { return }
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        guard let vc: BasicInformationViewController = UIStoryboard.instantiate(storyboard: .authentication) else { return }
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - TextField Delegate
extension RegisterViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.superview?.superview?.updateState(to: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.superview?.superview?.updateState(to: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTF {
            emailTF.becomeFirstResponder()
        } else if textField == emailTF {
            passwordTF.becomeFirstResponder()
        } else if textField == passwordTF {
            confirmPasswordTF.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
