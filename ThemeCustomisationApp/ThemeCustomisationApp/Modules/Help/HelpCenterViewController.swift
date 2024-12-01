//
//  HelpCenterViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 28/11/2024.
//

import UIKit
import SideMenu

class HelpCenterViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var iconsView: UIView!
    @IBOutlet weak var wallpapersView: UIView!

    // MARK: - Life Cycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        iconsView.addGradient(colors: [.themePink.withAlphaComponent(0.2),
                                       .themeBlue.withAlphaComponent(0.2)])
        wallpapersView.addGradient(colors: [.themePink.withAlphaComponent(0.2),
                                            .themeBlue.withAlphaComponent(0.2)])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func didTapIconsView(_ sender: Any) {
        guard let vc: IconHelpViewController = UIStoryboard.instantiate(storyboard: .help) else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapWallpapersView(_ sender: Any) {
        guard let vc: WallpaperHelpViewController = UIStoryboard.instantiate(storyboard: .help) else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        if navigationController?.isKind(of: SideMenuNavigationController.self) ?? false {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
}
