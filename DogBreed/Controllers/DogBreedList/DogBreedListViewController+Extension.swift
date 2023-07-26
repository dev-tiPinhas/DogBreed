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
        // if we get to the last item we fetch more elements
        if (collectionView.numberOfItems(inSection: 0) - 1) == indexPath.row {
            viewModel.fetchBreeds()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: if I have time present modaly the detailVC
    }
}
