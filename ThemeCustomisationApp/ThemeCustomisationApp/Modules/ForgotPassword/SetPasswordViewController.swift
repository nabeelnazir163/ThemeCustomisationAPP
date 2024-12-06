//
//  SetPasswordViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 06/12/2024.
//

import UIKit

class SetPasswordViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var stackViewBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        resetButton.addGradient()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        resetButton.titleLabel?.font = UIFont.SFProBold(with: 20)
        
        setupTextFields()
        setupHeadings()
        addKeyboardObservers()
        addTapGesture()
    }
    
    deinit {
        removeObservers()
    }
    
    private func setupTextFields() {
        passwordTF.delegate = self
        confirmPasswordTF.delegate = self
        
        passwordTF.returnKeyType = .next
        confirmPasswordTF.returnKeyType = .done
        
        passwordTF.font = UIFont.SFProRegular(with: 16)
        confirmPasswordTF.font = UIFont.SFProRegular(with: 16)
        
        passwordTF.keyboardType = .default
        confirmPasswordTF.keyboardType = .default
        
        passwordTF.isSecureTextEntry = true
        confirmPasswordTF.isSecureTextEntry = true
        
        passwordTF.superview?.superview?.updateState(to: false)
        confirmPasswordTF.superview?.superview?.updateState(to: false)
    }
    
    private func setupHeadings() {
        titleLabel.font = UIFont.SFProBold(with: 24)
        subTitleLabel.font = UIFont.SFProRegular(with: 16)
    }
    
    // MARK: - Actions
    @IBAction func didTapBackButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapSeePassword(_ sender: UIButton) {
        passwordTF.isSecureTextEntry.toggle()
    }
    
    @IBAction func didTapSeeConfirmPassword(_ sender: UIButton) {
        confirmPasswordTF.isSecureTextEntry.toggle()
    }
    
    @IBAction func didTapResetButton(_ sender: Any) {
        guard let vc: PasswordChangedViewController = UIStoryboard.instantiate(storyboard: .forgotPassword) else { return }
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
}

// MARK: - Keyboard Observers
extension SetPasswordViewController {
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            stackViewBottomConstraint.constant = keyboardHeight - 50
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        stackViewBottomConstraint.constant = .zero
    }
}

// MARK: - TextField Delegate
extension SetPasswordViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.superview?.superview?.updateState(to: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.superview?.superview?.updateState(to: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTF {
            confirmPasswordTF.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
