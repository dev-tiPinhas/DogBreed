//
//  APIServices.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 24/07/2023.
//

import Foundation
import UIKit

protocol APIServiceProtocol {
    func fetchBreeds(with page: Int, completion:  @escaping (Result<[Breed],Error>) -> Void)
}

public class APIService: APIServiceProtocol {
    let breedsURL: String = "https://api.thedogapi.com/v1/breeds"
    
    let stringlimit: String = "limit"
    let limit: String = "10"
    
    let stringAPIKey: String = "api_key"
    let APIKey: String = "live_28SPgO8FJ5nexbIuizwMuhLiH2aXau9anReZasO5KpqfCRuc3U0X2ztpNCYrX1mr"
    
    ///Used to control if we already reached the end of the API  list
    var next: Int = 0
    
    /// Used to retrieve the list of breeds.
    /// - Parameters:
    /// - page: The first elements to be shown, from here only after the we scroll again more elements are fetched
    func fetchBreeds(with page: Int, completion:  @escaping (Result<[Breed],Error>) -> Void) {
        guard let url = URL(string: breedsURL)?.appending(stringlimit, value: limit) else { return }
        
        URLSession.shared.dataTask(with: url.appending(stringAPIKey, value: APIKey)) { (data, response, error) in
            
            guard let data, error == nil else {
                completion(.failure(error!))
                debugPrint(error!)
                return
            }
            
            var decodedData: [Breed]?
            do {
                decodedData = try JSONDecoder().decode([Breed].self, from: data)
            } catch {
                completion(.failure(error))
                debugPrint(error)
            }
            
            guard let decodedData else {
                return
            }
            
            completion(.success(decodedData))
        }.resume()
    }
}
