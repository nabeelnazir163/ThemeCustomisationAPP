//
//  NotificationViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 03/12/2024.
//

import UIKit

class NotificationViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: NotificationTableViewCell.className,
                                 bundle: nil),
                           forCellReuseIdentifier: NotificationTableViewCell.className)
        tableView.contentInset.bottom = view.safeAreaInsets.bottom + 20
        tableView.dataSource = self
    }
    
    // MARK: - Actions
    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - Tableview delegate
extension NotificationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.className,
                                                       for: indexPath) as? NotificationTableViewCell else {
            return NotificationTableViewCell()
        }
        cell.mainView.addDropShadow(color: .appGray.withAlphaComponent(0.5))
        return cell
    }
}
