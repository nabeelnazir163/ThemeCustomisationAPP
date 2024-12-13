//
//  UpdatePasswordViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 13/12/2024.
//

import UIKit

class UpdatePasswordViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var oldPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    @IBOutlet weak var changePasswordButton: UIButton!
    
    // MARK: - Life Cycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        changePasswordButton.addGradient()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        addTapGesture()
    }
    
    private func setupTextFields() {
        oldPasswordTF.delegate = self
        newPasswordTF.delegate = self
        confirmPasswordTF.delegate = self
        
        oldPasswordTF.returnKeyType = .next
        newPasswordTF.returnKeyType = .next
        confirmPasswordTF.returnKeyType = .done
        
        oldPasswordTF.font = UIFont.SFProRegular(with: 16)
        newPasswordTF.font = UIFont.SFProRegular(with: 16)
        confirmPasswordTF.font = UIFont.SFProRegular(with: 16)
        
        oldPasswordTF.keyboardType = .default
        newPasswordTF.keyboardType = .default
        confirmPasswordTF.keyboardType = .default
        
        oldPasswordTF.isSecureTextEntry = true
        newPasswordTF.isSecureTextEntry = true
        confirmPasswordTF.isSecureTextEntry = true
        
        oldPasswordTF.superview?.superview?.updateState(to: false)
        newPasswordTF.superview?.superview?.updateState(to: false)
        confirmPasswordTF.superview?.superview?.updateState(to: false)
    }
    
    // MARK: - Actions
    @IBAction func didTapBackButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapSeeOldPassword(_ sender: UIButton) {
        oldPasswordTF.isSecureTextEntry.toggle()
    }
    
    @IBAction func didTapSeeNewPassword(_ sender: UIButton) {
        newPasswordTF.isSecureTextEntry.toggle()
    }
    
    @IBAction func didTapSeeConfirmPassword(_ sender: UIButton) {
        confirmPasswordTF.isSecureTextEntry.toggle()
    }
    
    @IBAction func didTapChangePasswordButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - TextField Delegate
extension UpdatePasswordViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.superview?.superview?.updateState(to: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.superview?.superview?.updateState(to: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == oldPasswordTF {
            newPasswordTF.becomeFirstResponder()
        } else if textField == newPasswordTF {
            confirmPasswordTF.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
