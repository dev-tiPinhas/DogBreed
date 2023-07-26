//
//  TabBarViewController.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 21/07/2023.
//

import Foundation
import UIKit

final class TabBarViewController: UITabBarController {
    
    private let labels: LabelsProtocol
    
    // MARK: Initialiazers
    
    init(labels: LabelsProtocol = Labels()) {
        self.labels = labels
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViewControllers()
    }
    
    // MARK: Setup
    private func setup() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    private func setupViewControllers() {
        let dogBreedListViewController = UINavigationController(rootViewController: DogBreedListViewController())
        dogBreedListViewController.tabBarItem.image = UIImage(systemName: "list.bullet.below.rectangle")
        dogBreedListViewController.tabBarItem.title = labels.getLabel(with: LocalizableKeys.TabBar.titleButton1)
        
        let searchDogBreedViewController = UINavigationController(rootViewController: SearchDogBreedViewController())
        searchDogBreedViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        searchDogBreedViewController.tabBarItem.title = labels.getLabel(with: LocalizableKeys.TabBar.titleButton2)
        
        viewControllers = [
            dogBreedListViewController,
            searchDogBreedViewController
        ]
    }
}
