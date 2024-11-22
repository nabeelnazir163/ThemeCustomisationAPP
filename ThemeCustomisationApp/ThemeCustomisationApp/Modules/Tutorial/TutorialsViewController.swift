//
//  TutorialsViewController.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 22/11/2024.
//

import UIKit

class TutorialsViewController: UIViewController {    
    // MARK: - Outlets
    @IBOutlet weak var tutorialCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - Properties
    var viewModel: TutorialsViewModel!
    private var observableId: Int?

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewToViewModelState()
    }
    
    /// Responsible to observer view state from CarDetailsViewModel
    private func bindViewToViewModelState() {
        observableId = viewModel.state.bind { [weak self] state in
            guard let self else { return }
            switch state {
            case .first, .second, .third:
                updateView()
            case .skip:
                Commons.shared.isFirstLaunch = false
                Commons.shared.navigateWindow(to: .home)
            }
        }
    }
    
    private func setupUI() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        tutorialCollectionView.backgroundColor = .clear
        tutorialCollectionView.register(UINib(nibName: TutorialsCollectionViewCell.className, bundle: nil),
                                        forCellWithReuseIdentifier: TutorialsCollectionViewCell.className)
        tutorialCollectionView.delegate = self
        tutorialCollectionView.dataSource = self
    }
    
    private func setupNextButton() {
        nextButton.setBackgroundImage(viewModel.getNextButtonBG(),
                                      for: .normal)
    }
    
    private func updateView() {
        setupNextButton()
        scrollView()
    }
    
    private func scrollView() {
        tutorialCollectionView.scrollToItem(at: IndexPath(item: viewModel.state.value.rawValue,
                                                          section: 0),
                                            at: .centeredHorizontally,
                                            animated: false)
    }
    
    // MARK: - Actions
    @IBAction func didTapSkipButton(_ sender: Any) {
        Commons.shared.isFirstLaunch = false
        Commons.shared.navigateWindow(to: .home)
    }
    
    @IBAction func didTapNextButton(_ sender: Any) {
        let lastState = viewModel.state.value.rawValue
        guard let newState = TutorialsViewModel.TutorialState(rawValue: lastState + 1) else { return }
        viewModel.updateState(to: newState)
    }
}

// MARK: - Collection View Delegate and Datasource
extension TutorialsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.tutorialList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorialsCollectionViewCell.className,
                                                            for: indexPath) as? TutorialsCollectionViewCell else {
            return TutorialsCollectionViewCell()
        }
        cell.item = viewModel.tutorialList[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        view.frame.size
    }
}
