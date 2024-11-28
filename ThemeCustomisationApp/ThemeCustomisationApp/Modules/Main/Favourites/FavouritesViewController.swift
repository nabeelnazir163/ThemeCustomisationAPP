//
//  FavouritesViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 23/11/2024.
//

import UIKit

class FavouritesViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet var appearanceButtons: [UIButton]!

    // MARK: - Properties
    var viewModel: FavouritesViewModel!
    private var mainDelegate: HomeMainDelegateAndDataSource?

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        viewModel.delegate = self
        setupMainCollectionView()
        updateAppeanceButton(for: .wallpaper)
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
    
    private func setupMainCollectionView() {
        mainCollectionView.register(UINib(nibName: WallpaperTileCollectionViewCell.className,
                                  bundle: nil),
                            forCellWithReuseIdentifier: WallpaperTileCollectionViewCell.className)
        
        mainCollectionView.register(UINib(nibName: IconCollectionViewCell.className,
                                  bundle: nil),
                            forCellWithReuseIdentifier: IconCollectionViewCell.className)
        
        mainCollectionView.contentInset.bottom = view.safeAreaInsets.bottom + 90
        mainDelegate = HomeMainDelegateAndDataSource(viewModel: viewModel)
        setCustomLayout(for: viewModel.selectedAppearance)
        mainCollectionView.delegate = mainDelegate
        mainCollectionView.dataSource = mainDelegate
    }
    
    private func setCustomLayout(for state: AppearanceOption) {
        let layout = PinterestLayout()
        layout.numberOfColumns = state == .icon ? 1 : 2
        layout.cellPadding = 5
        layout.delegate = mainDelegate
        mainCollectionView.collectionViewLayout = layout
    }
    
    // MARK: - Actions
    @IBAction func didUpdateAppearance(_ sender: UIButton) {
        guard let newState = AppearanceOption(rawValue: sender.tag),
              newState != viewModel.selectedAppearance else {
            return
        }
        setCustomLayout(for: newState)
        viewModel.updateSelectedAppearance(with: newState)
        updateAppeanceButton(for: newState)        
    }
}

// MARK: - HomeViewModelProtocol
extension FavouritesViewController: HomeViewModelProtocol {
    func reloadCategories() {
        
    }
    
    func reloadMainCV() {
        mainCollectionView.scrollToItem(at: IndexPath(item: 0,
                                                            section: 0),
                                              at: .top, animated: false)
        mainCollectionView.reloadData()
    }
}
