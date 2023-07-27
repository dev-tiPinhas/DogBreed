//
//  DogBreedListViewController+Extension.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 26/07/2023.
//

import Foundation
import UIKit

extension DogBreedListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItem = collectionView.numberOfItems(inSection: 0) - 1
        // if we get to the last item we fetch more elements
        if  indexPath.row == lastItem {
            viewModel.fetchBreeds()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: if I have time present modaly the detailVC
    }
}

// MARK: Constants

extension DogBreedListViewController {
    enum Constants {
        static let defaultItemHeight: CGFloat = 400
        static let gridItemHeight: CGFloat = 200
        static let collectionViewMargin: CGFloat = 40
        static let collectionViewSpacing: CGFloat = 30
    }
}
