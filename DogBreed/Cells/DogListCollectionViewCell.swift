//
//  DogListCollectionViewCell.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 26/07/2023.
//

import Foundation
import UIKit

final class DogListCollectionViewCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .clear
        
        return label
    }()
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
        
        return imageView
    }()
    
    var viewModel: DogListCellViewModelProtocol?
    
    // MARK: Initialisers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        titleLabel.text = ""
    }
    
    func configureCell(with viewModel: DogListCellViewModelProtocol) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        setupEvent()
        viewModel.fetchImage()
    }

    private func setupEvent() {
        self.viewModel?.events.showImage = { [weak self] image in
            self?.imageView.image = image
        }
    }
}
