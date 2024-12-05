//
//  PreviewIconViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 05/12/2024.
//

import UIKit

class PreviewIconViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var installBtnSuperView: UIView!
    @IBOutlet weak var installBtn: UIButton!

    // MARK: - Properties
    var viewModel: PreviewIconViewModel!
    
    // MARK: - Life Cycle Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        installBtn.addGradient(colors: [.themePink, .themeBlue])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        installBtnSuperView.addDropShadow(color: .black.withAlphaComponent(0.5),
                                       radius: 5)
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: SingleIconCollectionViewCell.className,
                                      bundle: nil),
                                forCellWithReuseIdentifier: SingleIconCollectionViewCell.className)
        collectionView.contentInset.bottom = 20
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Actions
    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - Collectionview delegaetes
extension PreviewIconViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let index = viewModel.selectedIconIndeces.firstIndex(of: indexPath.row) {
            viewModel.removeSelected(from: index)
        } else {
            viewModel.addToSelection(item: indexPath.row)
        }
        collectionView.reloadData()
    }
}
