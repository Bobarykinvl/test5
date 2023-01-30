//
//  SecondAnimationViewController.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 28.12.22.
//

import UIKit

final class SecondAnimationViewController: UIViewController {

    @IBOutlet weak var viewForAnimation: UIView!
    
    var animator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewForAnimation.center = view.center
        animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeIn)
        animator.addAnimations {
            self.viewForAnimation.backgroundColor = .green
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        animator.addCompletion { _ in
            self.animator = nil
        }
    }
    
    @IBAction func didSlide(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value) / 100
        
    }
}
