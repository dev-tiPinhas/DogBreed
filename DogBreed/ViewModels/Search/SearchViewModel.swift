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
    func makeSearchCellViewModel(with indexpath: IndexPath) -> SearchCellViewModelProtocol
}

final class SearchViewModel: SearchViewModelProtocol {
    // MARK: Properties
    private let serviceApi: APIServiceProtocol
    private var allItems: [Breed] = []
    private var itemToFilter: [Breed] = []
    
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
            
            switch result {
            case .success(let breeds):
                self.allItems = breeds
                self.itemToFilter = breeds
                self.events.handleResults?(self.itemToFilter)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    // MARK: Build ViewModels
    func makeSearchCellViewModel(with indexpath: IndexPath) -> SearchCellViewModelProtocol {
        let breed = itemToFilter[indexpath.row]
        
        return SearchCellViewModel(
            name: breed.name,
            group: breed.breedGroup?.rawValue,
            origin: breed.origin
        )
    }
}
