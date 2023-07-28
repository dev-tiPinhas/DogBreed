//
//  DogListCellViewModel.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 26/07/2023.
//

import Foundation
import UIKit

protocol DogListCellViewModelProtocol {
    func fetchImage()
    var title: String { get }
    var events: DogListCellViewModel.Events { get set }
}

final class DogListCellViewModel: DogListCellViewModelProtocol {
    private let imageFetcher: ImageFetcherProtocol
    private let image: Image
    var title: String
    
    struct Events {
        var showImage: ((UIImage) -> Void)?
    }
    
    var events: Events = Events()
    
    init(
        imageFetcher: ImageFetcherProtocol = ImageFetcher(),
        image: Image,
        title: String
    ) {
        self.imageFetcher = imageFetcher
        self.image = image
        self.title = title
    }
    
    // MARK: - convenience initializer
        convenience init() {
            self.init(imageFetcher: ImageFetcher(), image: Image(), title: "")
        }
    
    func fetchImage() {
        // Obtain the URL from our Image.url
        guard let urlString = image.url,
              let url = URL(string: urlString)
        else { return }
        
        imageFetcher.fetchImage(
            with: url,
            cacheKey: image.id
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let image):
                self.events.showImage?(image)
            }
        }
    }
}
