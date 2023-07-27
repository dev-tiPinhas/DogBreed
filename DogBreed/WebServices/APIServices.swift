//
//  APIServices.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 24/07/2023.
//

import Foundation
import UIKit

protocol APIServiceProtocol {
    func fetchDogBreeds(with page: Int, limit: Int, completion: @escaping (Result<[Breed], Error>) -> Void)
    func fetchAllBreeds(completion: @escaping (Result<[Breed],Error>) -> Void)
}

final class APIService: APIServiceProtocol {
    let error: NSError = NSError(domain: "", code: -1, userInfo: nil)
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchDogBreeds(with page: Int, limit: Int, completion: @escaping (Result<[Breed], Error>) -> Void) {
        guard var url = URL(string: Endpoints.baseURL)
        else {
            completion(.failure(error))
            return
        }
        
        url = url.appending(Endpoints.stringLimit, value: String(format: Endpoints.limit, limit))
        url = url.appending(Endpoints.stringPage, value: String(format: Endpoints.page, page))
        url = url.appending(Endpoints.stringAPIKey, value: Endpoints.APIKey)
        
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            
            guard let data,
                  error == nil
            else {
                completion(.failure(self.error))
                debugPrint(self.error)
                return
            }
            
            var result: [Breed]?
            do {
                result = try JSONDecoder().decode([Breed].self, from: data)
            } catch {
                completion(.failure(error))
                debugPrint(error)
            }
            
            guard let result else {
                return
            }
            
            completion(.success(result))
        }
        
        task.resume()
    }
    
    /// Used to retrieve the entire list of breeds.
    func fetchAllBreeds(completion: @escaping (Result<[Breed], Error>) -> Void) {
        guard let url = URL(string: Endpoints.baseURL) else {
            completion(.failure(error))
            return
        }
        
        let task = urlSession.dataTask(with: url.appending(Endpoints.stringAPIKey, value: Endpoints.APIKey)) { (data, response, error) in
            
            guard let data,
                  error == nil
            else {
                completion(.failure(self.error))
                debugPrint(self.error)
                return
            }
            
            var result: [Breed]?
            do {
                result = try JSONDecoder().decode([Breed].self, from: data)
            } catch {
                completion(.failure(error))
                debugPrint(error)
            }
            
            guard let result else {
                return
            }
            
            completion(.success(result))
        }
        
        task.resume()
    }
}
