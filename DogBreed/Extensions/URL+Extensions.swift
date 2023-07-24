//
//  URL+Extensions.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 24/07/2023.
//

import Foundation

extension URL {
    func appending(_ queryItem: String, value: String) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        
        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        
        let queryItem = URLQueryItem(name: queryItem, value: value)
        queryItems.append(queryItem)
        
        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems
        
        return urlComponents.url ?? absoluteURL
    }
}
