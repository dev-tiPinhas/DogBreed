//
//  DogListCollectionViewCell.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 26/07/2023.
//

import Foundation
import UIKit

final class DogListCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    
    private lazy var mainView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    var viewModel: DogListCellViewModelProtocol?
    
    // MARK: Initialisers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initialSetup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Overrides
    
    override func prepareForReuse() {
        imageView.image = nil
        titleLabel.text = ""
    }
    
    // MARK: Setup functions
    private func initialSetup() {
        backgroundColor = .quaternaryLabel
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    
    private func setupConstraints() {
        addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            mainView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            mainView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
        
        
        mainView.addArrangedSubview(imageView)
        mainView.addArrangedSubview(titleLabel)
    }
    
    private func setupEvent() {
        self.viewModel?.events.showImage = { [weak self] image in
            self?.imageView.image = image
        }
    }
    
    func configureCell(with viewModel: DogListCellViewModelProtocol) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        setupEvent()
        viewModel.fetchImage()
    }
}
