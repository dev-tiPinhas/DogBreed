//
//  DetailsViewController.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 27/07/2023.
//

import Foundation
import UIKit

final class DetailsViewController: UIViewController {
    // MARK: Properties
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    private lazy var breedNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.backgroundColor = .clear
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var breedCategoryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var breedCategoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var originTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var originLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var temperamentTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var temperamentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var loadingSpinner: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        
        return activityView
    }()
    
    private let labels: LabelsProtocol
    private var viewModel: DetailsViewModelProtocol
    
    // MARK: Initialisers
    
    init(
        labels: LabelsProtocol = Labels(),
        viewModel: DetailsViewModelProtocol
    ) {
        self.labels = labels
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleEvents()
        configureLabels()
    }
    
    // MARK: SetupUI
    
    private func setupUI() {
        title = labels.getLabel(with: LocalizableKeys.BreedDetails.title)
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(vStackView)
        view.addSubview(loadingSpinner)
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            vStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStackView.widthAnchor.constraint(equalToConstant: 300),
            
            imageView.topAnchor.constraint(equalTo: vStackView.bottomAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            
            loadingSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        addArrangedSubviews(views: [
            breedNameLabel,
            breedCategoryTitleLabel,
            breedCategoryLabel,
            originTitleLabel,
            originLabel,
            temperamentTitleLabel,
            temperamentLabel
        ])
        
        // Now we can fetch the image
        viewModel.fectImage()
    }
    
    private func addArrangedSubviews(views: [UIView]) {
        views.forEach { vStackView.addArrangedSubview($0) }
    }
    
    private func configureLabels() {
        breedNameLabel.text = viewModel.breedName
        breedCategoryTitleLabel.text = labels.getLabel(with: LocalizableKeys.BreedDetails.breedCategory)
        breedCategoryLabel.text = viewModel.breedCategory
        originTitleLabel.text = labels.getLabel(with: LocalizableKeys.BreedDetails.origin)
        originLabel.text = viewModel.origin
        temperamentTitleLabel.text = labels.getLabel(with: LocalizableKeys.BreedDetails.temperament)
        temperamentLabel.text = viewModel.temperament
    }
    
    private func handleEvents() {
        viewModel.events.handleImageFetch = { [weak self] image in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                self.imageView.image = image
                self.imageView.setNeedsDisplay()
            }
        }
        
        viewModel.events.handleLoading = { [weak self] shouldShow in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                if shouldShow {
                    self.loadingSpinner.startAnimating()
                } else {
                    self.loadingSpinner.stopAnimating()
                }
            }
        }
    }
}
