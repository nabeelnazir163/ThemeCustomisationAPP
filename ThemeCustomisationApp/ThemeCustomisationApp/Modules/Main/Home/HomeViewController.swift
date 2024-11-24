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
    
    @IBOutlet var appearanceButtons: [UIButton]!
    
    @IBOutlet var formaterButtons: [UIButton]!
    
    @IBOutlet weak var wallpapersCollectionView: UICollectionView!
    
    // MARK: - Properties
    var homeViewModel: HomeViewModel!
    private var categoryDelegateAndDataSource: CategegoryCellDelegateAndDataSource?
    private var wallpaperDelegateAndDataSource: WallPaperCellDelegateAndDataSource?

    // MARK: - Life Cycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        categoryBGView.addGradient(colors: [.themePink,
                                            .themeBlue])
        formaterButtons.first?.addGradient(colors: [.themePink,
                                                    .themeBlue])
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.delegate = self
        setupView()
    }
    
    private func setupView() {
        setupCollectionView()
        setupMainCollectionView()
        updateAppeanceButton(for: .wallpaper)
    }
    
    private func setupMainCollectionView() {
        wallpapersCollectionView.register(UINib(nibName: WallpaperTileCollectionViewCell.className,
                                  bundle: nil),
                            forCellWithReuseIdentifier: WallpaperTileCollectionViewCell.className)
        wallpapersCollectionView.contentInset.bottom = view.safeAreaInsets.bottom + 90
        wallpaperDelegateAndDataSource = WallPaperCellDelegateAndDataSource(viewModel: homeViewModel)
        let layout = PinterestLayout()
        layout.delegate = wallpaperDelegateAndDataSource
        wallpapersCollectionView.collectionViewLayout = layout
        wallpapersCollectionView.delegate = wallpaperDelegateAndDataSource
        wallpapersCollectionView.dataSource = wallpaperDelegateAndDataSource
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
    
    private func updateCVFormatterButton(for state: HomeViewModel.Format) {
        formaterButtons.forEach { button in
            if button.tag == state.rawValue {
                button.addGradient(colors: [.themePink,
                                            .themeBlue])
            } else {
                button.removeGradientLayer()
                button.backgroundColor = .clear
            }
        }
    }
    
    private func updateAppeanceButton(for state: HomeViewModel.AppearanceOption) {
        appearanceButtons.forEach { button in
            if button.tag == state.rawValue {
                button.addGradient(colors: [.themePink,
                                            .themeBlue])
            } else {
                button.removeGradientLayer()
                button.backgroundColor = .clear
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func didUpdateAppearance(_ sender: UIButton) {
        guard let newState = HomeViewModel.AppearanceOption(rawValue: sender.tag),
              newState != homeViewModel.selectedAppearance else {
            return
        }
        homeViewModel.updateSelectedAppearance(with: newState)
        updateAppeanceButton(for: newState)
    }
    
    @IBAction func didChangeFormat(_ sender: UIButton) {
        guard let newState = HomeViewModel.Format(rawValue: sender.tag),
              newState != homeViewModel.selectedFormat else {
            return
        }
        homeViewModel.updateFormatStyle(with: newState)
        updateCVFormatterButton(for: newState)
    }
}

// MARK: - HomeViewModelProtocol
extension HomeViewController: HomeViewModelProtocol {
    func reloadCategories() {
        categoryCV.reloadData()
    }
    func reloadMainCV() {
        wallpapersCollectionView.reloadData()
    }
}
