//
//  AbstractDetailViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 05/12/2024.
//

import UIKit

class AbstractDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var appearanceButtons: [UIButton]!

    @IBOutlet weak var buttonSuperView: UIView!
    
    // MARK: - Properties
    var viewModel: AbstractViewModel!
    private var mainDelegate: HomeMainDelegateAndDataSource?
    
    // MARK: - Life Cycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        buttonSuperView.addDropShadow(color: .appGray.withAlphaComponent(0.5))
        updateAppeanceButton(for: viewModel.selectedAppearance)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMainCollectionView()
        viewModel.delegate = self
    }
    
    private func setupMainCollectionView() {
        collectionView.register(UINib(nibName: WallpaperTileCollectionViewCell.className,
                                  bundle: nil),
                            forCellWithReuseIdentifier: WallpaperTileCollectionViewCell.className)
        
        collectionView.register(UINib(nibName: IconCollectionViewCell.className,
                                  bundle: nil),
                            forCellWithReuseIdentifier: IconCollectionViewCell.className)
        
        collectionView.contentInset.bottom = view.safeAreaInsets.bottom + 20
        mainDelegate = HomeMainDelegateAndDataSource(viewModel: viewModel)
        mainDelegate?.delegate = self
        setCustomLayout(for: viewModel.selectedAppearance)
        collectionView.delegate = mainDelegate
        collectionView.dataSource = mainDelegate
    }
    
    private func setCustomLayout(for state: AppearanceOption) {
        let layout = PinterestLayout()
        layout.numberOfColumns = state == .icon ? 1 : 2
        layout.cellPadding = 5
        layout.delegate = mainDelegate
        collectionView.collectionViewLayout = layout
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
        guard let newState = AppearanceOption(rawValue: sender.tag),
              newState != viewModel.selectedAppearance else {
            return
        }
        setCustomLayout(for: newState)
        viewModel.updateSelectedAppearance(with: newState)
        updateAppeanceButton(for: newState)
    }
    
    @IBAction func didSelectBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - HomeViewModelProtocol
extension AbstractDetailViewController: HomeViewModelProtocol {
    func reloadMainCV() {
        collectionView.scrollToItem(at: IndexPath(item: 0,
                                                            section: 0),
                                              at: .top, animated: false)
        collectionView.reloadData()
    }
}

// MARK: - HomeMainDataSourceProtocol
extension AbstractDetailViewController: HomeMainDataSourceProtocol {
    func collectionView(didSelectItemAt indexPath: IndexPath) {
        if viewModel.selectedAppearance == .wallpaper {
            guard let vc: PreviewWallpaperViewController = UIStoryboard.instantiate(storyboard: .wallpaper) else {
                return
            }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.viewModel = PreviewWallpaperViewModel(indexToScroll: indexPath.row)
            present(vc, animated: true)
        } else if viewModel.selectedAppearance == .theme {
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
