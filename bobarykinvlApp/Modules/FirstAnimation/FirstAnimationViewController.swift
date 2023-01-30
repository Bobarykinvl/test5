//
//  FirstAnimationViewController.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 25.12.22.
//

import UIKit

final class FirstAnimationViewController: UIViewController {

    @IBOutlet private weak var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 1.0, delay: 2.0) {
            self.animationView.transform = CGAffineTransform(rotationAngle: .pi)
            self.animationView.alpha = 0.0
        }
    }
}
