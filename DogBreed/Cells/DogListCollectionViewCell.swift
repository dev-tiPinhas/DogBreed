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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .lightText
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.layer.cornerRadius = titleLabel.frame.height / 2
        imageView.layer.cornerRadius = imageView.frame.height / 2
    }
    
    // MARK: Setup functions
    private func initialSetup() {
        backgroundColor = .lightText
        
        layer.cornerRadius = 20
        layer.masksToBounds = false
    }
    
    private func setupConstraints() {
        addSubview(imageView)
        imageView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            titleLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -50),
            titleLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -20)
        ])
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
