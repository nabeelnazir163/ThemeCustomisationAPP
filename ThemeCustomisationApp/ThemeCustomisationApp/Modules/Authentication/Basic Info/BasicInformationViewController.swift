//
//  BasicInformationViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 13/12/2024.
//

import UIKit

class BasicInformationViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var firstnameTF: UITextField!
    @IBOutlet weak var lastnameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    // MARK: - Life Cycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        continueButton.addGradient()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addTapGesture()
    }
    
    private func setupViews() {
        setupTextFields()
    }
    
    private func setupTextFields() {
        firstnameTF.delegate = self
        lastnameTF.delegate = self
        phoneTF.delegate = self
        
        firstnameTF.returnKeyType = .next
        lastnameTF.returnKeyType = .next
        phoneTF.returnKeyType = .done
        
        firstnameTF.font = UIFont.SFProRegular(with: 16)
        lastnameTF.font = UIFont.SFProRegular(with: 16)
        phoneTF.font = UIFont.SFProRegular(with: 16)
        
        firstnameTF.keyboardType = .default
        lastnameTF.keyboardType = .default
        phoneTF.keyboardType = .phonePad
        
        firstnameTF.superview?.superview?.updateState(to: false)
        lastnameTF.superview?.superview?.updateState(to: false)
        phoneTF.superview?.superview?.updateState(to: false)
    }
    
    // MARK: - Actions
    @IBAction func didTapBack(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapContinueButton(_ sender: Any) {
    }
    
    @IBAction func didTapSkipButton(_ sender: Any) {
    }
}

// MARK: - Textfield delegates
extension BasicInformationViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.superview?.superview?.updateState(to: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.superview?.superview?.updateState(to: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstnameTF {
            lastnameTF.becomeFirstResponder()
        } else if textField == lastnameTF {
            phoneTF.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
