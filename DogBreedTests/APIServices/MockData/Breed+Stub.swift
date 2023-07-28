//
//  Breed+Stub.swift
//  DogBreedTests
//
//  Created by Tiago Pinheiro on 28/07/2023.
//

@testable import DogBreed
import Foundation
import UIKit

extension Breed {
    enum Stub {
        static func makeStub(
            id: Int? = 1,
            name: String? = "Affenpinscher",
            origin: String? = "Germany, France",
            temperament: String? = "Stubborn, Curious, Playful, Adventurous, Active, Fun-loving",
            breedGroup: BreedGroup? = BreedGroup(rawValue: "Toy"),
            bredFor: String? = "Small rodent hunting, lapdog",
            image: Image = Image(
                id: "BJa4kxc4X",
                url: "https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg"
            )
        ) -> Breed {
            return Breed(
                id: id,
                name: name,
                origin: origin,
                temperament: temperament,
                breedGroup: breedGroup,
                bredFor: bredFor,
                image: image
            )
        }
    }
}
