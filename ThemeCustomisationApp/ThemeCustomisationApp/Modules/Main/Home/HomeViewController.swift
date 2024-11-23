//
//  HomeViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 22/11/2024.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var categoryBGView: UIView!
    @IBOutlet weak var categoryCV: UICollectionView!
    
    // MARK: - Properties
    var homeViewModel: HomeViewModel!
    private var categoryDelegateAndDataSource: CategegoryCellDelegateAndDataSource?

    // MARK: - Life Cycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        categoryBGView.addGradient(colors: [.themePink,
                                            .themeBlue])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.delegate = self
        setupView()
    }
    
    private func setupView() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        categoryCV.register(UINib(nibName: HomeCategoryCollectionViewCell.className,
                                  bundle: nil),
                            forCellWithReuseIdentifier: HomeCategoryCollectionViewCell.className)
        categoryCV.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        categoryDelegateAndDataSource = CategegoryCellDelegateAndDataSource(viewModel: homeViewModel)
        categoryCV.delegate = categoryDelegateAndDataSource
        categoryCV.dataSource = categoryDelegateAndDataSource
    }
}

// MARK: - HomeViewModelProtocol
extension HomeViewController: HomeViewModelProtocol {
    func reloadCategories() {
        categoryCV.reloadData()
    }
}
