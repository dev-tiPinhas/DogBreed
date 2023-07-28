//
//  MockAPIServices.swift
//  DogBreedTests
//
//  Created by Tiago Pinheiro on 28/07/2023.
//

@testable import DogBreed
import Foundation

final class MockAPIServices: APIServiceProtocol {
    var mock: Result<[DogBreed.Breed], Error> = .failure(NSError(domain: "", code: -1, userInfo: nil))
    
    func fetchDogBreeds(with page: Int, limit: Int, completion: @escaping (Result<[Breed], Error>) -> Void) {
        completion(mock)
    }
    func fetchAllBreeds(completion: @escaping (Result<[Breed],Error>) -> Void) {
        completion(mock)
    }
}
