//
//  CustomTabbar.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 23/11/2024.
//

import Foundation
import UIKit

class CustomTabBar: UIView {
    enum TabbarState: Int {
        case home = 0, categories, search, favourite
    }
    @IBOutlet var iconsSuperViews: [UIView]!
    @IBOutlet var tabbarIcons: [UIImageView]!
    @IBOutlet var tabbarItemLabels: [UILabel]!
    
    // MARK: - Outlets
    
    // MARK: - Properties
    private var tabbarState: TabbarState = .home
    var buttonTapped: ((TabbarState) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGradient(colors: [.themePink, .themeBlue])
    }

    private func setupView() {
        layoutIfNeeded()
    }
    
    func updateTabbarView(for state: TabbarState) {
        updateBGView(for: state)
        updateIconTint(for: state)
        updateLabelVisibility(for: state)
    }
    
    private func updateBGView(for state: TabbarState) {
        iconsSuperViews.forEach { view in
            if view.tag == state.rawValue {
                view.backgroundColor = .white
            } else {
                view.backgroundColor = .primaryText
            }
        }
    }
    
    private func updateIconTint(for state: TabbarState) {
        tabbarIcons.forEach { icon in
            if icon.tag == state.rawValue {
                icon.tintColor = .primaryText
            } else {
                icon.tintColor = .white
            }
        }
    }
    
    private func updateLabelVisibility(for state: TabbarState) {
        tabbarItemLabels.forEach { label in
            if label.tag == state.rawValue {
                label.isHidden = false
            } else {
                label.isHidden = true
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func didSelectTabbarItem(_ sender: UIButton) {
        guard let newState = TabbarState(rawValue: sender.tag),
              tabbarState.rawValue != newState.rawValue else { return }
        tabbarState = newState
        updateTabbarView(for: newState)
        switch sender.tag {
        case 0: buttonTapped?(.home)
        case 1: buttonTapped?(.categories)
        case 2: buttonTapped?(.search)
        default: buttonTapped?(.favourite)
        }
    }
}
