//
//  DogListViewModel.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 26/07/2023.
//

import Foundation

protocol DogListViewModelProtocol {
    func fetchBreeds()
    func makeCellViewModel(for indexPath: IndexPath) -> DogListCellViewModel
    var events: DogListViewModel.Events { get set }
}

final class DogListViewModel: DogListViewModelProtocol {
    private let apiService: APIServiceProtocol
    private let labels: LabelsProtocol
    
    private var items: [Breed] = []
    private var pageControl: Int = -1
    
    /// Limit the number of items for request
    private static let limitOfItems: Int = 10
    
    /// Completion handlers
    struct Events {
        var handleDogsResults: (([Breed]) -> Void)?
        var handleLoading: ((Bool) -> Void)?
    }
    
    var events: Events = Events()
    
    init(
        apiService: APIServiceProtocol = APIService(),
        labels: LabelsProtocol = Labels()
    ) {
        self.apiService = apiService
        self.labels = labels
    }
    
    func fetchBreeds() {
        events.handleLoading?(true)
        pageControl += 1
        apiService.fetchDogBreeds(with: pageControl, limit: DogListViewModel.limitOfItems) { [weak self] results in
            guard let self else { return }
            self.events.handleLoading?(false)
            switch results {
            case .success(let breeds):
                self.items += breeds
                self.events.handleDogsResults?(self.items)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func makeCellViewModel(for indexPath: IndexPath) -> DogListCellViewModel {
        let breed = items[indexPath.row]
    
        return DogListCellViewModel(
            image: breed.image,
            title: breed.name ?? ""
        )
    }
}
