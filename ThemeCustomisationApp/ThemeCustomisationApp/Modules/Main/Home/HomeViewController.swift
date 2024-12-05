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
        mainDelegate?.delegate = self
        setCustomLayout(for: homeViewModel.selectedAppearance)
        wallpapersCollectionView.delegate = mainDelegate
        wallpapersCollectionView.dataSource = mainDelegate
    }
    
    private func setCustomLayout(for state: AppearanceOption) {
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
    
    private func updateCVFormatterButton(for state: Format) {
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
    
    private func updateAppeanceButton(for state: AppearanceOption) {
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
        guard let newState = AppearanceOption(rawValue: sender.tag),
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
        guard let newState = Format(rawValue: sender.tag),
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

// MARK: - HomeMainDataSourceProtocol
extension HomeViewController: HomeMainDataSourceProtocol {
    func collectionView(didSelectItemAt indexPath: IndexPath) {
        if homeViewModel.selectedAppearance == .wallpaper {
            guard let vc: PreviewWallpaperViewController = UIStoryboard.instantiate(storyboard: .wallpaper) else {
                return
            }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.viewModel = PreviewWallpaperViewModel(indexToScroll: indexPath.row)
            present(vc, animated: true)
        } else if homeViewModel.selectedAppearance == .theme {
            guard let vc: PreviewThemeViewController = UIStoryboard.instantiate(storyboard: .preview) else {
                return
            }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.viewModel = PreviewThemeViewModel()
            present(vc, animated: true)
        } else {
            guard let vc: PreviewIconViewController = UIStoryboard.instantiate(storyboard: .preview) else {
                return
            }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.viewModel = PreviewIconViewModel()
            present(vc, animated: true)
        }
    }
}
