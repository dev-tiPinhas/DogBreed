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
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .top
        
        return stackView
    }()
    
    private lazy var breedTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var breedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var breedGroupTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var breedGroupLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var originTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var originLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var titlesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        
        return stackView
    }()
    
    private lazy var valuesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .trailing
        
        return stackView
    }()
    
    private let labels: LabelsProtocol
    
    // MARK: Initialisers
    
    init(labels: LabelsProtocol = Labels()) {
        self.labels = labels
        super.init(style: .default, reuseIdentifier: String(describing: SearchBreedTableViewCell.self))
        setupAnchors()
        configureDefaultLabeltValues()
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
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            mainStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            mainStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        ])
        
        addArrangedSubviews(
            views: [titlesStackView, valuesStackView],
            stackView: mainStackView
        )
        addArrangedSubviews(
            views: [breedTitleLabel, breedGroupTitleLabel, originTitleLabel],
            stackView: titlesStackView
        )
        addArrangedSubviews(
            views: [breedLabel, breedGroupLabel, originLabel],
            stackView: valuesStackView
        )
    }
    
    private func configureDefaultLabeltValues() {
        breedTitleLabel.text = labels.getLabel(with: LocalizableKeys.SearchBreeds.breedName)
        breedGroupTitleLabel.text = labels.getLabel(with: LocalizableKeys.SearchBreeds.breedGroup)
        originTitleLabel.text = labels.getLabel(with: LocalizableKeys.SearchBreeds.origin)
    }
    
    // This could be in an extension -> Will do it if have the time
    private func addArrangedSubviews(views: [UIView], stackView: UIStackView) {
        views.forEach { stackView.addArrangedSubview($0) }
    }
    
    func configureCell(viewModel: SearchCellViewModelProtocol) {
        breedLabel.text = viewModel.name
        breedGroupLabel.text = viewModel.group
        originLabel.text = viewModel.origin
    }
}
