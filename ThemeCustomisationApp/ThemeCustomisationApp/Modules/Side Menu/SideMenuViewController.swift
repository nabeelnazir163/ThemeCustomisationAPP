//
//  SideMenuViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 23/11/2024.
//

import UIKit

class SideMenuViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var mainView: UIView!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.roundTopRightCorner(cornerRadius: 60)
    }

    // MARK: - Actions
    @IBAction func didTapClose(_ sender: Any) {
        dismiss(animated: true)
    }
}
