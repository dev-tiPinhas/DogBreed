//
//  UIAlertController+Extensions.swift
//  DogBreed
//
//  Created by Tiago Pinheiro on 28/07/2023.
//

import Foundation
import UIKit

extension UIAlertController {
    static func makeAlert(
        error: Error,
        labels: LabelsProtocol,
        completion: @escaping () -> Void
    ) -> UIAlertController {
        let alert = UIAlertController(
            title: labels.getLabel(with: LocalizableKeys.UIAlert.title),
            message: labels.getLabel(with: LocalizableKeys.UIAlert.description) + error.localizedDescription,
            preferredStyle: UIAlertController.Style.alert
        )
        
        // Add an action okButton -> With no action (just dismiss the alertController)
        alert.addAction(UIAlertAction(title: labels.getLabel(with: LocalizableKeys.UIAlert.okButton), style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: labels.getLabel(with: LocalizableKeys.UIAlert.refreshButton), style: .default, handler: { action in
            switch action.style {
            case .default:
                completion()
            default:
                return
            }
        }))
        
        return alert
    }
}


