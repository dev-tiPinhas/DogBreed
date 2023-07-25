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
        let options: [KingfisherOptionsInfoItem] = [.cacheOriginalImage]
        
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
