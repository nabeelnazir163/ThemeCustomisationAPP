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
    
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterView: FilterView!
    
    @IBOutlet weak var wallpapersCollectionView: UICollectionView!
    
    @IBOutlet weak var mainFormatterView: UIView!
    
    // MARK: - Properties
    var homeViewModel: HomeViewModel!
    private var categoryDelegateAndDataSource: CategegoryCellDelegateAndDataSource?
    private var mainDelegate: HomeMainDelegateAndDataSource?

    // MARK: - Life Cycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        categoryBGView.addGradient(colors: [.themePink,
                                            .themeBlue])
        updateCVFormatterButton(for: homeViewModel.selectedFormat)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.delegate = self
        setupView()
    }
    
    private func setupView() {
        setupCollectionView()
        setupMainCollectionView()
        filterView.setupView()
        filterView.delegate = self
        updateAppeanceButton(for: .wallpaper)
    }
    
    private func setupMainCollectionView() {
        wallpapersCollectionView.register(UINib(nibName: WallpaperTileCollectionViewCell.className,
                                  bundle: nil),
                            forCellWithReuseIdentifier: WallpaperTileCollectionViewCell.className)
        
        wallpapersCollectionView.register(UINib(nibName: IconCollectionViewCell.className,
                                  bundle: nil),
                            forCellWithReuseIdentifier: IconCollectionViewCell.className)
        
        wallpapersCollectionView.contentInset.bottom = view.safeAreaInsets.bottom + 90
        mainDelegate = HomeMainDelegateAndDataSource(viewModel: homeViewModel)
        setCustomLayout(for: homeViewModel.selectedAppearance)
        wallpapersCollectionView.delegate = mainDelegate
        wallpapersCollectionView.dataSource = mainDelegate
    }
    
    private func setCustomLayout(for state: HomeViewModel.AppearanceOption) {
        let layout = PinterestLayout()
        layout.numberOfColumns = state == .icon ? 1 : 2
        layout.cellPadding = 5
        layout.delegate = mainDelegate
        wallpapersCollectionView.collectionViewLayout = layout
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
            button.removeGradientLayer()
            if button.tag == state.rawValue {
                button.addGradient(colors: [.themePink,
                                            .themeBlue])
            } else {
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
        filterView.isHidden = true
        guard let newState = HomeViewModel.AppearanceOption(rawValue: sender.tag),
              newState != homeViewModel.selectedAppearance else {
            return
        }
        setCustomLayout(for: newState)
        homeViewModel.updateSelectedAppearance(with: newState)
        updateAppeanceButton(for: newState)
        
        mainFormatterView.isHidden = newState != .wallpaper
    }
    
    @IBAction func didChangeFormat(_ sender: UIButton) {
        filterView.isHidden = true
        guard let newState = HomeViewModel.Format(rawValue: sender.tag),
              newState != homeViewModel.selectedFormat else {
            return
        }
        homeViewModel.updateFormatStyle(with: newState)
        updateCVFormatterButton(for: newState)
    }

    @IBAction func didSelectFilterView(_ sender: Any) {
        filterView.isHidden.toggle()
    }
}

// MARK: - HomeViewModelProtocol
extension HomeViewController: HomeViewModelProtocol {
    func reloadCategories() {
        categoryCV.reloadData()
        filterView.isHidden = true
    }
    func reloadMainCV() {
        wallpapersCollectionView.scrollToItem(at: IndexPath(item: 0,
                                                            section: 0),
                                              at: .top, animated: false)
        wallpapersCollectionView.reloadData()
    }
}

// MARK: - FilterViewProtocol
extension HomeViewController: FilterViewProtocol {
    func filterView(_ filterView: FilterView, didSelect item: FilterView.FilterOption) {
        filterLabel.text = item.rawValue.capitalized
    }
}
