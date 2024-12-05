//
//  PreviewThemeViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 01/12/2024.
//

import UIKit

class PreviewThemeViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var wallpaperBtn: UIButton!
    @IBOutlet weak var iconBtn: UIButton!
    
    @IBOutlet weak var sepLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var sepWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var saveBtnSuperView: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    
    // MARK: - Properties
    var viewModel: PreviewThemeViewModel!
    
    // MARK: - Life Cycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        saveBtn.addGradient(colors: [.themePink, .themeBlue])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        saveBtnSuperView.addDropShadow(color: .black.withAlphaComponent(0.5),
                                       radius: 5)
        setupCollectionView()
        didTapCategories(wallpaperBtn)
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: PreviewWallpaperCollectionViewCell.className,
                                      bundle: nil),
                                forCellWithReuseIdentifier: PreviewWallpaperCollectionViewCell.className)
        collectionView.register(UINib(nibName: SingleIconCollectionViewCell.className,
                                      bundle: nil),
                                forCellWithReuseIdentifier: SingleIconCollectionViewCell.className)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupUpLayout() {
        if viewModel.selectedThemeType == .wallpaper {
            let layout = UPCarouselFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSizeMake(collectionView.frame.width * 0.75,
                                         collectionView.frame.height)
            collectionView.collectionViewLayout = layout
        } else {
            collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        }
    }
    
    private func updateStateButtonTitle() {
        saveBtn.setTitle(viewModel.selectedThemeType == .wallpaper ? "SAVE" : "INSTALL SELECTED ICONS",
                         for: .normal)
    }
    
    // MARK: - Actions
    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapCategories(_ sender: UIButton) {
        guard let newState = PreviewThemeViewModel.ThemeType(rawValue: sender.tag),
              newState != viewModel.selectedThemeType else { return }
        viewModel.updateType(for: newState)
        setupUpLayout()
        
        sepLeadingConstraint.constant = sender.frame.origin.x
        sepWidthConstraint.constant = sender.frame.width
        collectionView.scrollToItem(at: IndexPath(item: 0,
                                                  section: 0),
                                    at: .top, animated: false)
        collectionView.reloadData()
        updateStateButtonTitle()
    }
}

// MARK: - Collectionview delegaetes
extension PreviewThemeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.selectedThemeType == .wallpaper {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PreviewWallpaperCollectionViewCell.className,
                for: indexPath
            ) as? PreviewWallpaperCollectionViewCell else {
                return PreviewWallpaperCollectionViewCell()
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SingleIconCollectionViewCell.className,
                for: indexPath
            ) as? SingleIconCollectionViewCell else {
                return SingleIconCollectionViewCell()
            }
            let isSelected = viewModel.selectedIconIndeces.contains(indexPath.row)
            cell.configureCell(isSelected: isSelected)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard viewModel.selectedThemeType == .icons else { return }
        if let index = viewModel.selectedIconIndeces.firstIndex(of: indexPath.row) {
            viewModel.removeSelected(from: index)
        } else {
            viewModel.addToSelection(item: indexPath.row)
        }
        collectionView.reloadData()
    }
}
