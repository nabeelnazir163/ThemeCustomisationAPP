//
//  FilterView.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 25/11/2024.
//

import UIKit
protocol FilterViewProtocol: AnyObject {
    func filterView(_ filterView: FilterView, didSelect item: FilterView.FilterOption)
}

class FilterView: UIView {
    enum FilterOption: String {
        case trending, recent, exclusive
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var filterTableView: UITableView!
    
    // MARK: - Properties
    private var items: [FilterOption] = [FilterOption.trending,
                                         FilterOption.recent,
                                         FilterOption.exclusive]
    private var selectItem: FilterOption = .trending
    
    weak var delegate: FilterViewProtocol?
    
    // MARK: - Life Cycle Methods
    func setupView() {
        self.isHidden = true
        setupTableView()
    }
    
    private func setupTableView() {
        filterTableView.register(UINib(nibName: FilterTableViewCell.className,
                                       bundle: nil),
                                 forCellReuseIdentifier: FilterTableViewCell.className)
        filterTableView.delegate = self
        filterTableView.dataSource = self
    }
}

// MARK: - Tableview delegate and Datasource
extension FilterView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.className,
                                                       for: indexPath) as? FilterTableViewCell else {
            return FilterTableViewCell()
        }
        cell.configureView(item: items[indexPath.row],
                           isSelected: items[indexPath.row] == selectItem)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectItem = items[indexPath.row]
        filterTableView.reloadData()
        self.isHidden = true
        delegate?.filterView(self, didSelect: selectItem)
    }
}
