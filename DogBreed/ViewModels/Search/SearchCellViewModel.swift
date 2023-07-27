//
//  SearchCellViewModel.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 27/07/2023.
//

import Foundation

protocol SearchCellViewModelProtocol {
    var name: String? { get }
    var group: String? { get }
    var origin: String? { get }
}

final class SearchCellViewModel: SearchCellViewModelProtocol {
    var name: String?
    var group: String?
    var origin: String?
    
    init(
        name: String? = nil,
        group: String? = nil,
        origin: String? = nil
    ) {
        self.name = name
        self.group = group
        self.origin = origin
    }
}
