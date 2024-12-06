//
//  OTPVerficationViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 06/12/2024.
//

import UIKit

class OTPVerficationViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var stackviewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var otpLabels: [UILabel]!
    @IBOutlet weak var otpTextField: UITextField!
    
    @IBOutlet weak var resendLabel: UILabel!
    
    @IBOutlet weak var resentButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    // MARK: - Properties
    var viewModel: OTPVerificationViewModel!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.onViewDidLoad()
        addTapGesture()
        setupView()
        addKeyboardObservers()
    }
    
    private func setupView() {
        setupHeadings()
        setupOTPFields()
        updateTimer(value: 60)
        setupBottomButtons()
    }
    
    deinit {
        removeObservers()
    }
    
    private func setupHeadings() {
        titleLabel.font = UIFont.SFProBold(with: 24)
        subTitleLabel.font = UIFont.SFProRegular(with: 16)
    }
    
    private func setupOTPFields() {
        otpLabels.forEach { label in
            label.font = UIFont.SFProBold(with: 24)
            label.textColor = .primaryText
            label.backgroundColor = .clear
            label.textAlignment = .center
            label.updateState(to: false)
            label.cornerRadius = 8
        }
        otpTextField.keyboardType = .numberPad
        otpTextField.delegate = self
    }
    
    private func setupBottomButtons() {
        resentButton.titleLabel?.font = UIFont.SFProBold(with: 20)
        confirmButton.titleLabel?.font = UIFont.SFProBold(with: 20)
        
        resentButton.isButtonEnabled = false
        confirmButton.isButtonEnabled = true
    }
    
    // MARK: - Actions
    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapResendButton(_ sender: Any) {
        viewModel.setupTimer()
    }
}

// MARK: - Keyboard Observers
extension OTPVerficationViewController {
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
            DispatchQueue.main.async(execute: { [weak self] in
                guard let self else { return }
                stackviewBottomConstraint.constant = keyboardHeight
                view.layoutIfNeeded()
            })
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        stackviewBottomConstraint.constant = .zero
        view.layoutIfNeeded()
    }
}

// MARK: - TextField Delegate
extension OTPVerficationViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        otpLabels.first?.updateState(to: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField.text?.isEmpty ?? true {
            otpLabels.forEach { label in
                label.updateState(to: false)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            return true
        }
        
        if textField.text?.count ?? 0 <= 3 {
            return true
        }
        
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let count = textField.text?.count else { return }
        
        switch count {
        case 0:
            otpLabels[0].text = nil
            otpLabels[1].text = nil
            otpLabels[2].text = nil
            otpLabels[3].text = nil
            
            otpLabels[0].updateState(to: true)
            otpLabels[1].updateState(to: false)
            otpLabels[2].updateState(to: false)
            otpLabels[3].updateState(to: false)
        case 1:
            otpLabels[0].text = textField.text?.character(at: 0)
            otpLabels[1].text = nil
            otpLabels[2].text = nil
            otpLabels[3].text = nil
            
            otpLabels[0].updateState(to: true)
            otpLabels[1].updateState(to: true)
            otpLabels[2].updateState(to: false)
            otpLabels[3].updateState(to: false)
        case 2:
            otpLabels[1].text = textField.text?.character(at: 1)
            otpLabels[2].text = nil
            otpLabels[3].text = nil
            
            otpLabels[0].updateState(to: true)
            otpLabels[1].updateState(to: true)
            otpLabels[2].updateState(to: true)
            otpLabels[3].updateState(to: false)
        case 3:
            otpLabels[2].text = textField.text?.character(at: 2)
            otpLabels[3].text = nil
            
            otpLabels[0].updateState(to: true)
            otpLabels[1].updateState(to: true)
            otpLabels[2].updateState(to: true)
            otpLabels[3].updateState(to: true)
        case 4:
            otpLabels[3].text = textField.text?.character(at: 3)
            
            otpLabels[0].updateState(to: true)
            otpLabels[1].updateState(to: true)
            otpLabels[2].updateState(to: true)
            otpLabels[3].updateState(to: true)
        default:
            otpLabels.forEach { label in
                label.text = nil
            }
        }
    }
}

// MARK: - OTPVerificationViewModelProtocol
extension OTPVerficationViewController: OTPVerificationViewModelProtocol {
    func updateTimer(value: Int) {
        resendLabel.attributedText = formatTimer(with: value)
    }
    
    private func formatTimer(with time: Int) -> NSAttributedString {
        let formattedTime = time.formatSecondsToMMSS()
        let text = "Resend code after \(formattedTime)"
        
        let attributedString = NSMutableAttributedString(string: text)
        
        let completeRange = attributedString.mutableString.range(of: text)
        let range = attributedString.mutableString.range(of: formattedTime)
        
        let font = UIFont.SFProRegular(with: 16) ?? UIFont.systemFont(ofSize: 16)
        
        attributedString.addAttribute(.font, value: font, range: completeRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.gray, range: completeRange)
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.darkGray, range: range)
        
        let attributes: [NSAttributedString.Key: Any] = [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.darkGray
            ]
        attributedString.addAttributes(attributes, range: range)
        
        return attributedString
    }
    
    func countDownTimeCompleted() {
        resendLabel.attributedText = NSAttributedString(string: "Resend Code Now")
        
        resentButton.isButtonEnabled = true
        confirmButton.isButtonEnabled = false
    }
}
