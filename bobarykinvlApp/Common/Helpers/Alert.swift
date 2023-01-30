//
//  Alert.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 11.01.23.
//

import Foundation
import UIKit

final class Alert {
    
    private var coreDataManager = CoreDataManager()
    
    func getAlertController(tableView: UITableView) -> UIAlertController {
        let alertViewController = UIAlertController(title: "Add new animation", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default) { action in
            let titleTextField = alertViewController.textFields?[0]
            let imageURLTextField = alertViewController.textFields?[1]
            let typeOfAnimationField = alertViewController.textFields?[2]
            if let titleName = titleTextField?.text, let imageURL = imageURLTextField?.text, let animationType = typeOfAnimationField?.text {
                let animationTypeNew = Int(animationType)
                self.coreDataManager.saveAnimation(title: titleName, imageURL: imageURL, animationType: animationTypeNew ?? 0)
                tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertViewController.addTextField { (textField) in
            textField.placeholder = "Enter Title name"
        }
        alertViewController.addTextField { (textField) in
            textField.placeholder = "Enter imageURL"
        }
        alertViewController.addTextField { (textField) in
            textField.placeholder = "Enter AnimationType"
        }
        alertViewController.addAction(cancelAction)
        alertViewController.addAction(addAction)
        
        return alertViewController
    }
}

