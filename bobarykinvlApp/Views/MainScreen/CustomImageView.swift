//
//  CustomImageView.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 30.12.22.
//

import UIKit

class CustomImageView: UIImageView {
    private let spinner = UIActivityIndicatorView()
    
    func loadingImage(URLString: String) {
        addSpinner()
        let queue = OperationQueue()
        if let url = URL(string: URLString) {
            queue.addOperation {
                let data = try? Data(contentsOf: url)
                OperationQueue.main.addOperation {
                    self.image = UIImage(data: data ?? Data())
                    self.spinner.removeFromSuperview()
                }
            }
        }
    }
    
    func addSpinner() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        addSubview(spinner)
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.startAnimating()
    }
}
