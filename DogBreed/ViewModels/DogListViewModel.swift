//
//  DogListViewModel.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 26/07/2023.
//

import Foundation

protocol DogListViewModelProtocol {
    func fetchBreeds()
    func sortElements(sortType: DogListViewModel.SortType)
    func makeCellViewModel(for indexPath: IndexPath) -> DogListCellViewModel
    func makeDetailsViewModel(for indexPath: IndexPath) -> DetailsViewModelProtocol
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
        var handleErrors: ((Error) -> Void)?
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
                self.events.handleErrors?(error)
            }
        }
    }
    
    // MARK: Make ViewModels
    func makeCellViewModel(for indexPath: IndexPath) -> DogListCellViewModel {
        let breed = items[indexPath.row]
    
        return DogListCellViewModel(
            image: breed.image,
            title: breed.name ?? ""
        )
    }
    
    func makeDetailsViewModel(for indexPath: IndexPath) -> DetailsViewModelProtocol {
        let breed = items[indexPath.row]
        
        return DetailsViewModel(
            breedName: breed.name,
            breedCategory: breed.bredFor,
            temperament: breed.temperament,
            origin: breed.origin,
            image: breed.image
        )
    }
    
    func sortElements(sortType: SortType) {
        sortElements(with: sortType)
    }
    
    // MARK: Private Functions
    
    private func sortElements(with sortType: SortType) {
        switch sortType {
        case .alphabetical:
            items = items.sorted { $0.name ?? "" < $1.name ?? "" }
        case .reversed:
            items = items.sorted { $0.name ?? "" > $1.name ?? "" }
        default:
            return
        }
        
        self.events.handleDogsResults?(self.items)
    }
}

extension DogListViewModel {
    enum SortType {
        case alphabetical
        case reversed
        case none
    }
}
