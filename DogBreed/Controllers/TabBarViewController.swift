//
//  TabBarViewController.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 21/07/2023.
//

import Foundation
import UIKit

final class TabBarViewController: UITabBarController {
    // MARK: Life Cycle
    let test: APIServiceProtocol = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViewControllers()
        
        test.fetchBreeds(with: 0) { (results) in
            // we already have the breeds (with only one page...)
            print(results)
        }
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
        dogBreedListViewController.tabBarItem.title = "Dogs List"
        
        let searchDogBreedViewController = UINavigationController(rootViewController: SearchDogBreedViewController())
        searchDogBreedViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        searchDogBreedViewController.tabBarItem.title = "Search Dogs"
        
        viewControllers = [
            dogBreedListViewController,
            searchDogBreedViewController
        ]
    }
}
