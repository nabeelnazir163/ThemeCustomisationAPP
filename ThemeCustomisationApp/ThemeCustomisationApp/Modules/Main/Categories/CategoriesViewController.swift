//
//  CategoriesViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 23/11/2024.
//

import UIKit

class CategoriesViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var categoriesCV: UICollectionView!
    
    // MARK: - Properties
    var viewModel: CategoriesViewModel!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        categoriesCV.register(UINib(nibName: CategoriesCollectionViewCell.className,
                                    bundle: nil),
                              forCellWithReuseIdentifier: CategoriesCollectionViewCell.className)
        categoriesCV.contentInset.bottom = view.safeAreaInsets.bottom + 90
        categoriesCV.delegate = self
        categoriesCV.dataSource = self
    }
}

// MARK: -  Collectionview delegate and Datasource
extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoriesCollectionViewCell.className,
            for: indexPath
        ) as? CategoriesCollectionViewCell else {
            return CategoriesCollectionViewCell()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width,
               height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc: AbstractDetailViewController = UIStoryboard.instantiate(storyboard: .abstract) else { return }
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle  = .crossDissolve
        vc.viewModel = AbstractViewModel()
        present(vc, animated: true)
    }
}
