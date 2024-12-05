//
//  SearchViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 23/11/2024.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var wallpaperBtn: UIButton!
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var iconBtn: UIButton!
    @IBOutlet weak var themeBtn: UIButton!
    
    @IBOutlet weak var sepLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var sepWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    // MARK: - Properties
    var searchViewModel: SearchViewModel!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        didTapCategories(wallpaperBtn)
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        searchCollectionView.register(UINib(nibName: WallpaperTileCollectionViewCell.className,
                                            bundle: nil),
                                      forCellWithReuseIdentifier: WallpaperTileCollectionViewCell.className)
        searchCollectionView.register(UINib(nibName: IconCollectionViewCell.className,
                                            bundle: nil),
                                      forCellWithReuseIdentifier: IconCollectionViewCell.className)
        searchCollectionView.register(UINib(nibName: CategoriesCollectionViewCell.className,
                                            bundle: nil),
                                      forCellWithReuseIdentifier: CategoriesCollectionViewCell.className)
        searchCollectionView.contentInset.bottom = view.safeAreaInsets.bottom + 90
        
        setCustomLayout(for: .wallpapers)
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
    }
    
    private func setCustomLayout(for type: SearchViewModel.SearchType) {
        let layout = PinterestLayout()
        if type == .icons || type == .categories {
            layout.numberOfColumns = 1
        } else {
            layout.numberOfColumns = 2
        }
        layout.cellPadding = 5
        layout.delegate = self
        searchCollectionView.collectionViewLayout = layout
    }
    
    // MARK: - Actions
    @IBAction func didTapCategories(_ sender: UIButton) {
        guard let newState = SearchViewModel.SearchType(rawValue: sender.tag),
              newState != searchViewModel.selectedType else { return }
        searchViewModel.updateType(for: newState)
        
        sepLeadingConstraint.constant = sender.frame.origin.x
        sepWidthConstraint.constant = sender.frame.width
        
        setCustomLayout(for: newState)
        
        searchCollectionView.scrollToItem(at: IndexPath(item: 0,
                                                            section: 0),
                                              at: .top, animated: false)
        searchCollectionView.reloadData()
    }
}

// MARK: - Collectionview delegate and Datasource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch searchViewModel.selectedType {
        case .wallpapers, .themes:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WallpaperTileCollectionViewCell.className,
                for: indexPath
            ) as? WallpaperTileCollectionViewCell else {
                return WallpaperTileCollectionViewCell()
                
            }
            return cell
            
        case .icons:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: IconCollectionViewCell.className,
                for: indexPath
            ) as? IconCollectionViewCell else {
                return IconCollectionViewCell()
                
            }
            return cell
            
        case .categories:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoriesCollectionViewCell.className,
                for: indexPath
            ) as? CategoriesCollectionViewCell else {
                return CategoriesCollectionViewCell()
                
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        if searchViewModel.selectedType == .wallpapers {
            let width = (collectionView.frame.width - 10) / 2
            let height: CGFloat = width * 1.3
            if indexPath.item % 3 == 0 {
                return height * 1.6
            } else {
                return height
            }
        } else if searchViewModel.selectedType == .icons {
            return 180
        } else if searchViewModel.selectedType == .categories {
            return 150
        } else {
            return 330
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searchViewModel.selectedType == .wallpapers {
            guard let vc: PreviewWallpaperViewController = UIStoryboard.instantiate(storyboard: .wallpaper) else {
                return
            }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.viewModel = PreviewWallpaperViewModel(indexToScroll: indexPath.row)
            present(vc, animated: true)
        } else if searchViewModel.selectedType == .themes {
            guard let vc: PreviewThemeViewController = UIStoryboard.instantiate(storyboard: .preview) else {
                return
            }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.viewModel = PreviewThemeViewModel()
            present(vc, animated: true)
        } else if searchViewModel.selectedType == .categories {
            guard let vc: AbstractDetailViewController = UIStoryboard.instantiate(storyboard: .abstract) else {
                return
            }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            vc.viewModel = AbstractViewModel()
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
