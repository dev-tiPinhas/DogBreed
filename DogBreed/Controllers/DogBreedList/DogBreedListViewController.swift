//
//  DogBreedListViewController.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 25/07/2023.
//

import Foundation
import UIKit

final class DogBreedListViewController: UIViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, Breed>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Breed>
    
    // MARK: Properties
    private lazy var dataSource: DataSource = makeDataSource()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            DogListCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: DogListCollectionViewCell.self)
        )
        
        return collectionView
    }()
    
    private lazy var defaultCollectionViewFlowLayout: UICollectionViewFlowLayout = {
       let listCollectionViewFlowLayout = UICollectionViewFlowLayout()
        listCollectionViewFlowLayout.scrollDirection = .vertical
        listCollectionViewFlowLayout.minimumLineSpacing = Constants.collectionViewSpacing
        listCollectionViewFlowLayout.itemSize = CGSize(
            width: UIScreen.main.bounds.width - (Constants.collectionViewMargin * 2),
            height: Constants.defaultItemHeight
        )
        
        return listCollectionViewFlowLayout
    }()
    
    private lazy var gridCollectionViewFlowLayout: UICollectionViewFlowLayout = {
       let gridCollectionViewFlowLayout = UICollectionViewFlowLayout()
        gridCollectionViewFlowLayout.scrollDirection = .vertical
        gridCollectionViewFlowLayout.minimumLineSpacing = Constants.collectionViewSpacing
        gridCollectionViewFlowLayout.minimumInteritemSpacing = Constants.collectionViewSpacing
        gridCollectionViewFlowLayout.itemSize = CGSize(
            width: (UIScreen.main.bounds.width - Constants.collectionViewMargin) / 2,
            height: Constants.gridItemHeight
        )
        
        return gridCollectionViewFlowLayout
    }()
    
    private lazy var loadingSpinner: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style:  .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        
        return activityIndicator
    }()
    
    private var isDefaultLayout = true
    private let labels: LabelsProtocol
    var viewModel: DogListViewModelProtocol
    
    // MARK: Initialisers
    
    init(
        labels: LabelsProtocol = Labels(),
        viewModel: DogListViewModelProtocol = DogListViewModel()
    ) {
        self.labels = labels
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        handleEvents()
        viewModel.fetchBreeds()
    }
     
    // MARK: - Overrides
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        /// Invalidate the layout when changing from List to Grid View
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
    }
    
    // MARK: Setup
    
    private func setupLayout() {
        title = labels.getLabel(with: LocalizableKeys.DogsList.title)
        
        // collectionView stuff
        collectionView.delegate = self
        collectionView.collectionViewLayout = defaultCollectionViewFlowLayout
         
        view.addSubview(collectionView)
        view.addSubview(loadingSpinner)
        
        setupViewsAnchors()
    }
    
    private func setupViewsAnchors() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            loadingSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func handleEvents() {
        viewModel.events.handleDogsResults = { [weak self] breeds in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.applySnpShot(items: breeds)
            }
        }
        
        viewModel.events.handleLoading = { [weak self] shouldShow in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                if shouldShow {
                    self.loadingSpinner.startAnimating()
                } else {
                    self.loadingSpinner.stopAnimating()
                }
            }
        }
    }
    
    private func applySnpShot(items: [Breed], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.zero])
        snapshot.appendItems(items)
        
        self.dataSource.apply(snapshot, animatingDifferences: animatingDifferences) {
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, indexPath, item ->
                UICollectionViewCell? in
                return self?.configureCell(at: indexPath, item: item)
            })
        
        return dataSource
    }
    
    private func configureCell(at indexPath: IndexPath, item: Breed) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DogListCollectionViewCell.self), for: indexPath) as? DogListCollectionViewCell else {
            preconditionFailure("reuserIndentifier not recognized")
        }
        
        cell.configureCell(with: viewModel.makeCellViewModel(for: indexPath))
        return cell
    }
}

