//
//  SearchBreedTableViewCell.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 27/07/2023.
//

import Foundation
import UIKit

final class SearchBreedTableViewCell: UITableViewCell {
    // MARK: Properties
    
    private lazy var breedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var breedGroupLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var originLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let labels: LabelsProtocol
    
    // MARK: Initialisers
    
    init(labels: LabelsProtocol = Labels()) {
        self.labels = labels
        super.init(style: .default, reuseIdentifier: String(describing: SearchBreedTableViewCell.self))
        setupAnchors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        breedLabel.text = ""
        breedGroupLabel.text = ""
        originLabel.text = ""
    }
    
    private func setupAnchors() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 40)
        ])
        
        stackView.addArrangedSubview(breedLabel)
        stackView.addArrangedSubview(breedGroupLabel)
        stackView.addArrangedSubview(originLabel)
    }
    
    func configureCell(viewModel: SearchCellViewModelProtocol) {
        breedLabel.text = viewModel.name
        breedGroupLabel.text = viewModel.group
        originLabel.text = viewModel.origin
    }
}
