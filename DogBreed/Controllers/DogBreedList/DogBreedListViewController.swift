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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(DogListCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: DogListCollectionViewCell.self))
        
        return collectionView
    }()
    
    private lazy var defaultCollectionViewFlowLayout: UICollectionViewFlowLayout = {
       let listCollectionViewFlowLayout = UICollectionViewFlowLayout()
        // TODO: define the actual flow layout -> later :cry
        return listCollectionViewFlowLayout
    }()
    
    private lazy var gridCollectionViewFlowLayout: UICollectionViewFlowLayout = {
       let gridCollectionViewFlowLayout = UICollectionViewFlowLayout()
        // TODO: define the actual flow layout -> later :cry
        return gridCollectionViewFlowLayout
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
        handleEvents()
        viewModel.fetchBreeds()
    }
    
     
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
        
        setupViewsAnchors()
    }
    
    private func setupViewsAnchors() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func handleEvents() {
        viewModel.events.handleDogsResults = { [weak self] breeds in
            DispatchQueue.main.async {
                // TODO: applySnapshot
            }
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
            preconditionFailure("CellWithReuseIdentifier not recognized")
        }
        
        cell.configureCell(with: viewModel.makeCellViewModel(for: indexPath))
        return cell
    }
}

