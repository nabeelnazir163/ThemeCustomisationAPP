//
//  SideMenuTableViewCell.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 29/11/2024.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var leadingIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var trailingIcon: UIImageView!
    @IBOutlet weak var switchView: UIView!
    @IBOutlet weak var switchBall: UIView!
    
    // MARK: - Properties
    private var isSwitchOn = false
    
    var item: SideMenuItem? {
        didSet {
            leadingIcon.image = item?.icon
            titleLabel.text = item?.item.rawValue
            
            if item?.type == .details {
                switchView.isHidden = true
                trailingIcon.isHidden = false
            } else {
                switchView.isHidden = false
                trailingIcon.isHidden = true
            }
            
            if isSwitchOn {
                turnOnSwitch(withAnimation: false)
            } else {
                turnOffSwitch(withAnimation: false)
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func didTapSwitch(_ sender: UIButton) {
        if isSwitchOn {
            turnOffSwitch(withAnimation: true, sender: sender)
        } else {
            turnOnSwitch(withAnimation: true, sender: sender)
        }
    }
    
    private func turnOnSwitch(withAnimation: Bool,
                              sender: UIButton? = nil) {
        let animationSpeed = withAnimation ? 0.5 : 0
        sender?.isUserInteractionEnabled = false
        switchBall.transform = CGAffineTransform(translationX: 8,
                                                 y: 0)
        
        UIView.animate(withDuration: animationSpeed) { [weak self] in
            guard let self else { return }
            switchBall.layoutIfNeeded()
        } completion: { [weak self] _ in
            guard let self else { return }
            isSwitchOn = true
            sender?.isUserInteractionEnabled = true
        }
    }
    
    private func turnOffSwitch(withAnimation: Bool,
                               sender: UIButton? = nil) {
        let animationSpeed = withAnimation ? 0.5 : 0
        switchBall.transform = .identity
        sender?.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: animationSpeed) { [weak self] in
            guard let self else { return }
            switchBall.layoutIfNeeded()
        } completion: { [weak self] _ in
            guard let self else { return }
            isSwitchOn = false
            sender?.isUserInteractionEnabled = true
        }
    }
}
