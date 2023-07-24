//
//  TabBarViewController.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 21/07/2023.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    // MARK: Life Cycle
    let test: APIServiceProtocol = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test.fetchBreeds(with: 0) { (results) in
            // we already have the breeds (with only one page...)
            print(results)
        }
    }
    
    // MARK: Setup
    
}

// MARK: UITabBarControllerDelegate

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // TODO: Handle didselect
    }
}
