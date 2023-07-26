//
//  Labels.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 26/07/2023.
//

import Foundation

protocol LabelsProtocol {
    func getLabel(with key: String) -> String
}

final class Labels: LabelsProtocol {
    func getLabel(with key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
