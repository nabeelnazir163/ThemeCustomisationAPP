//
//  SideMenuViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 23/11/2024.
//

import UIKit

class SideMenuViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var premimumView: UIView!
    @IBOutlet weak var getAccessButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var sideMenuViewModel: SideMenuViewModel!
    
    // MARK: - Life Cycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        getAccessButton.addGradient(colors: [.themePink,
                                             .themeBlue])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        setupPremiumView()
        setupTableView()
    }
    
    private func setupPremiumView() {
        premimumView.cornerRadius = 8
        premimumView.addDropShadow(color: .black.withAlphaComponent(0.2))
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: SideMenuTableViewCell.className,
                                 bundle: nil),
                           forCellReuseIdentifier: SideMenuTableViewCell.className)
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Actions
    @IBAction func didTapClose(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - TableView Delegate and Datasource
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sideMenuViewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.className,
                                                       for: indexPath) as? SideMenuTableViewCell else {
            return SideMenuTableViewCell()
        }
        cell.item = sideMenuViewModel.items[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = sideMenuViewModel.items[indexPath.row]
        switch item.item {
        case .helpCenter:
            guard let vc: HelpCenterViewController = UIStoryboard.instantiate(storyboard: .help) else { return }
            navigationController?.pushViewController(vc,
                                                     animated: true)
        default: break
            // Do thing for now
        }
    }
}
