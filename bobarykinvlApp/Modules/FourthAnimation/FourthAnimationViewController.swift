//
//  FourthAnimationViewController.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 1.01.23.
//

import UIKit

final class FourthAnimationViewController: UIViewController {

    @IBOutlet private weak var footballAnimationImageView: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.5, options: [.autoreverse], animations: {
            self.footballAnimationImageView.frame.origin.y = self.view.frame.maxY - 135 - 150
            
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.5, animations: {
                self.footballAnimationImageView.transform = CGAffineTransform(rotationAngle: .pi)
            })
        }) { _ in
            self.footballAnimationImageView.center = self.view.center
        }
    }
}
