//
//  SearchDogBreedViewController.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 25/07/2023.
//

import Foundation
import UIKit

final class SearchDogBreedViewController: UIViewController {
    // MARK: Properties
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = labels.getLabel(with: LocalizableKeys.SearchBreeds.placeHolder)
        
        return searchController
    }()
    
    private lazy var loadingSpinner: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicatorView
    }()
    
    private var viewModel: SearchViewModelProtocol
    private let labels: LabelsProtocol
    
    // MARK: Initialisers
    
    init(
        viewModel: SearchViewModelProtocol = SearchViewModel(),
        labels: LabelsProtocol = Labels()
    ) {
        self.viewModel = viewModel
        self.labels = labels
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAnchors()
    }
    
    // MARK: Setup
    
    private func setupUI() {
        title = labels.getLabel(with: LocalizableKeys.SearchBreeds.title)
        // so the title goes to nav bar when scrolling up, and is expanded when the content offset of the scrollView is 0
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        
        view.backgroundColor = .white
    }
    
    private func setupAnchors() {
        view.addSubview(tableView)
        view.addSubview(loadingSpinner)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            loadingSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: UITableViewDelegate & UITableViewDataSource
extension SearchDogBreedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0 // go get it in the viewModel
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // open details VC
    }
}

// MARK:
extension SearchDogBreedViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // perform search on ViewModel
    }
}



