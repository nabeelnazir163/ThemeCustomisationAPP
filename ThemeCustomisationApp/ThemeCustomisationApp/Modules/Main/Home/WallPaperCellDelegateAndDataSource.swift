//
//  WallPaperCellDelegateAndDataSource.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 23/11/2024.
//

import UIKit

class WallPaperCellDelegateAndDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, PinterestLayoutDelegate {
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WallpaperTileCollectionViewCell.className,
                                                            for: indexPath) as? WallpaperTileCollectionViewCell else {
            return HomeCategoryCollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        let width = (collectionView.frame.width - 10) / 2
        let height: CGFloat = width * 1.3
        if viewModel.selectedFormat == .randomTile {
            if indexPath.item % 3 == 0 {
                return height * 1.6
            } else {
                return height
            }
        } else {
            return height
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
