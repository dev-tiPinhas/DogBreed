//
//  SearchViewModel.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 27/07/2023.
//

import Foundation
import UIKit

protocol SearchViewModelProtocol {
    var events: SearchViewModel.Events { get set }
    func fetchResults()
    func numberOfItems() -> Int
    func search(for breedName: String)
    func makeSearchCellViewModel(with indexpath: IndexPath) -> SearchCellViewModelProtocol
    func makeDetailsViewModel(for indexPath: IndexPath) -> DetailsViewModelProtocol
}

final class SearchViewModel: SearchViewModelProtocol {
    // MARK: Properties
    private let serviceApi: APIServiceProtocol
    private var allItems: [Breed] = []
    private var itemsToFilter: [Breed] = []
    
    /// Completion handlers
    struct Events {
        var handleResults: (([Breed]) -> Void)?
        var handleLoading: ((Bool) -> Void)?
    }
    
    var events: Events = Events()
    
    init(serviceApi: APIServiceProtocol = APIService()) {
        self.serviceApi = serviceApi
    }
    
    func fetchResults() {
        fetchBreeds()
    }
    
    private func fetchBreeds() {
        events.handleLoading?(true)
        serviceApi.fetchAllBreeds { [weak self] result in
            guard let self else { return }
            
            self.events.handleLoading?(false)
            switch result {
            case .success(let breeds):
                self.allItems = breeds
                self.itemsToFilter = breeds
                self.events.handleResults?(self.itemsToFilter)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func numberOfItems() -> Int {
        return itemsToFilter.count
    }
    
    func search(for breedName: String) {
        itemsToFilter = allItems.filter{
            $0.name?.hasPrefix(breedName) ?? false
        }
        
        events.handleResults?(itemsToFilter)
    }
    
    // MARK: Build ViewModels
    func makeSearchCellViewModel(with indexpath: IndexPath) -> SearchCellViewModelProtocol {
        let breed = itemsToFilter[indexpath.row]
        
        return SearchCellViewModel(
            name: breed.name,
            group: breed.breedGroup?.rawValue,
            origin: breed.origin
        )
    }
    
    func makeDetailsViewModel(for indexPath: IndexPath) -> DetailsViewModelProtocol {
        let breed = itemsToFilter[indexPath.row]
        
        return DetailsViewModel(
            breedName: breed.name,
            breedCategory: breed.bredFor,
            temperament: breed.temperament,
            origin: breed.origin,
            image: breed.image
        )
    }
}
