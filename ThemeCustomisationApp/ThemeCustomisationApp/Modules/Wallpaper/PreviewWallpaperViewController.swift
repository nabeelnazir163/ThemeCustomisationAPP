//
//  PreviewWallpaperViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 01/12/2024.
//

import UIKit

class PreviewWallpaperViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Properties
    var viewModel: PreviewWallpaperViewModel!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView.scrollToItem(at: IndexPath(row: viewModel.indexToScroll,
                                                  section: 0),
                                    at: .centeredHorizontally,
                                    animated: false)
    }
    
    private func setupViews() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UPCarouselFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSizeMake(collectionView.frame.width * 0.75,
                                     collectionView.frame.height)
        collectionView.collectionViewLayout = layout
        
        collectionView.register(UINib(nibName: PreviewWallpaperCollectionViewCell.className,
                                      bundle: nil),
                                forCellWithReuseIdentifier: PreviewWallpaperCollectionViewCell.className)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Actions
    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - Collectionview delegaetes
extension PreviewWallpaperViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PreviewWallpaperCollectionViewCell.className,
            for: indexPath
        ) as? PreviewWallpaperCollectionViewCell else {
            return PreviewWallpaperCollectionViewCell()
        }
        return cell
    }
}
