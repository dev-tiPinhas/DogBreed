//
//  MockImageFetcher.swift
//  DogBreedTests
//
//  Created by Tiago Pinheiro on 28/07/2023.
//

@testable import DogBreed
import Foundation
import UIKit

final class MockImageFetcher: ImageFetcherProtocol {
    var mock: Result<UIImage, Error> = .failure(NSError(domain: "", code: -1, userInfo: nil))
    
    func fetchImage(
        with url: URL,
        cacheKey: String?,
        completion: @escaping ((Result<UIImage, Error>) -> Void)
    ) {
        completion(mock)
    }
}
