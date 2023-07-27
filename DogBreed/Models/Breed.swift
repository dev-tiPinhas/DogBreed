//
//  Breed.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 21/07/2023.
//

import Foundation

struct Breed: Codable, Hashable {
    let id: Int?
    let name: String?
    let origin: String?
    let temperament: String?
    let breedGroup: BreedGroup?
    let bredFor: String?
    let image: Image
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case origin
        case temperament
        case breedGroup = "breed_group"
        case bredFor = "bred_for"
        case image
    }
}

// MARK: Breed Group

enum BreedGroup: String, Codable, Hashable {
    case herding = "Herding"
    case hound = "Hound"
    case mixed = "Mixed"
    case nonSporting = "Non-Sporting"
    case sporting = "Sporting"
    case terrier = "Terrier"
    case toy = "Toy"
    case working = "Working"
    case empty = ""
}

struct Image: Codable, Hashable {
    var id: String?
    var url: String?
}
