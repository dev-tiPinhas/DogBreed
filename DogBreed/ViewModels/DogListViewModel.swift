//
//  DogListViewModel.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 26/07/2023.
//

import Foundation

protocol DogListViewModelProtocol {
    func fetchBreeds()
}

final class DogListViewModel: DogListViewModelProtocol {
    
    private let apiService: APIServiceProtocol
    private let labels: LabelsProtocol
    
    private var items: [Breed] = []
    private var pageControl: Int = -1
    
    /// Limit the number of items for request
    private static let limitOfItems: Int = 10
    
    init(
        apiService: APIServiceProtocol = APIService(),
        labels: LabelsProtocol = Labels()
    ) {
        self.apiService = apiService
        self.labels = labels
    }
    
    func fetchBreeds() {
        // TODO: display loading
        pageControl += 1
        apiService.fetchDogBreeds(with: pageControl, limit: DogListViewModel.limitOfItems) { [weak self] results in
            // TODO: stop loading
            switch results {
            case .success(let breeds):
                self?.items = breeds
                // TODO: show dogs
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
