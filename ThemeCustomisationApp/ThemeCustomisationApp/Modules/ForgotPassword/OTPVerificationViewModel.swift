//
//  OTPVerificationViewModel.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 06/12/2024.
//

import Foundation

protocol OTPVerificationViewModelProtocol: AnyObject {
    func updateTimer(value: Int)
    func countDownTimeCompleted()
}

final class OTPVerificationViewModel {
    private var timer: Timer?
    private var countDownTime = 60
    
    weak var delegate: OTPVerificationViewModelProtocol?
    
    func onViewDidLoad() {
        setupTimer()
    }
    
    func setupTimer() {
        countDownTime = 60
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            countDownTime -= 1
            
            if countDownTime <= 0 {
                delegate?.countDownTimeCompleted()
                timer?.invalidate()
                timer = nil
            } else {
                delegate?.updateTimer(value: countDownTime)
            }
        })
    }
}
