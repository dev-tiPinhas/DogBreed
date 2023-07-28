//
//  ImageFetcher.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 25/07/2023.
//

import Foundation
import UIKit
import Kingfisher

protocol ImageFetcherProtocol {
    func fetchImage(
        with url: URL,
        cacheKey: String?,
        completion: @escaping ((Result<UIImage, Error>) -> Void)
    )
}

final class ImageFetcher: ImageFetcherProtocol {
    func fetchImage(
        with url: URL,
        cacheKey: String?,
        completion: @escaping ((Result<UIImage, Error>) -> Void)
    ) {
        // We were using .cacheOriginalImage but the after fetching the first time an image we would never fetch it again -> problems in the details screen 
        let options: [KingfisherOptionsInfoItem] = [.forceRefresh]
        
        let resource: Kingfisher.KF.ImageResource = Kingfisher.KF.ImageResource(
            downloadURL: url,
            cacheKey: cacheKey
        )
        
        Kingfisher.KingfisherManager.shared.retrieveImage(with: resource, options: options) { result in
            switch result {
            case .success(let result):
                completion(.success(result.image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
