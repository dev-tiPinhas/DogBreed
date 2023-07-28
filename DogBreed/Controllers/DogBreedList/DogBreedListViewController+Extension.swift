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
        let detailsViewModel = viewModel.makeDetailsViewModel(for: indexPath)
        
        present(DetailsViewController(viewModel: detailsViewModel), animated: true)
    }
}

// MARK: Constants

extension DogBreedListViewController {
    enum Constants {
        static let defaultItemHeight: CGFloat = 250
        static let gridItemHeight: CGFloat = 200
        static let collectionViewMargin: CGFloat = 70
        static let collectionViewSpacing: CGFloat = 20
    }
}
