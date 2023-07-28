//
//  DetailsViewModel.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 27/07/2023.
//

import Foundation
import UIKit

protocol DetailsViewModelProtocol {
    var breedName: String? { get }
    var breedCategory: String? { get }
    var temperament: String? { get }
    var origin: String? { get }
    
    func fectImage()
    var events: DetailsViewModel.Events { get set }
}

final class DetailsViewModel: DetailsViewModelProtocol {
    var breedName: String?
    var breedCategory: String?
    var temperament: String?
    var origin: String?
    
    struct Events {
        var handleImageFetch: ((UIImage) -> Void)?
        var handleLoading: ((Bool) -> Void)?
    }
    
    var events: Events = Events()
    
    private var image: Image
    private let imageFetcher: ImageFetcherProtocol
    
    init(
        breedName: String? = nil,
        breedCategory: String? = nil,
        temperament: String? = nil,
        origin: String? = nil,
        image: Image,
        imageFetcher: ImageFetcherProtocol = ImageFetcher()
    ) {
        self.breedName = breedName
        self.breedCategory = breedCategory
        self.temperament = temperament
        self.origin = origin
        self.image = image
        self.imageFetcher = imageFetcher
    }
    
    func fectImage() {
        guard let url = URL(string: image.url ?? "") else { return }
        
        events.handleLoading?(true)
        imageFetcher.fetchImage(
            with: url,
            cacheKey: image.id
        ) { [weak self] result in
                guard let self else { return }
                
                self.events.handleLoading?(false)
                switch result {
                case .failure(let error):
                    debugPrint(error)
                case .success(let image):
                    self.events.handleImageFetch?(image)
                }
            }
        
    }
}

