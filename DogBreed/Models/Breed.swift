//
//  Breed.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 21/07/2023.
//

import Foundation
import UIKit

struct Breed: Codable {
    var id: Int?
    var name: String?
    var origin: String?
    var temperament: String?
    var breed_group: String?
    var bred_for: String?
    var image: Image
}

struct Image: Codable {
    var id: String?
    var url: String?
}
