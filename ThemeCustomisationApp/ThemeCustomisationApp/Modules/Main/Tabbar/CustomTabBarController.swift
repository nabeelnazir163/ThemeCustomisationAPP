//
//  CustomTabBarController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 23/11/2024.
//
import UIKit

class CustomTabBarController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var customTabbar: CustomTabBar!
    
    // MARK: - Properties
    private var currentViewController: UIViewController?

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomTabBar()
        switchToViewController(for: .home)
    }

    private func setupCustomTabBar() {
        customTabbar.updateTabbarView(for: .home)
        customTabbar.buttonTapped = { [weak self] state in
            self?.switchToViewController(for: state)
        }
    }

    private func switchToViewController(for state: CustomTabBar.TabbarState) {
        currentViewController?.view.removeFromSuperview()
        currentViewController?.removeFromParent()

        let newViewController: UIViewController
        switch state {
        case .home:
            guard let homeVC: HomeViewController = UIStoryboard.instantiate(storyboard: .main) else { return }
            newViewController = homeVC
        case .categories:
            guard let catVC: CategoriesViewController = UIStoryboard.instantiate(storyboard: .main) else { return }
            newViewController = catVC
        case .search:
            guard let searchVC: SearchViewController = UIStoryboard.instantiate(storyboard: .main) else { return }
            newViewController = searchVC
        default:
            guard let favVC: FavouritesViewController = UIStoryboard.instantiate(storyboard: .main) else { return }
            newViewController = favVC
        }

        addChild(newViewController)
        view.insertSubview(newViewController.view, belowSubview: customTabbar)
        newViewController.view.frame = view.bounds
        newViewController.didMove(toParent: self)
        currentViewController = newViewController
    }
}
