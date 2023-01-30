//
//  ThirdAnimationViewController.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 28.12.22.
//

import UIKit

final class ThirdAnimationViewController: UIViewController {

    @IBOutlet private weak var animatedView: UIView!
    private var animator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIViewPropertyAnimator(duration: 2.0, curve: .easeInOut, animations: {
            self.animatedView.backgroundColor = .blue
            self.animatedView.layer.cornerRadius = 70
        })
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        animatedView.addGestureRecognizer(panGesture)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        animator.addCompletion { _ in
            self.animator = nil
        }
    }
    
    @objc func didPan(_ panGesture: UIPanGestureRecognizer) {
        let newPosition = panGesture.translation(in: self.view)
        let currentX = animatedView.center.x
        let currentY = animatedView.center.y
        let final = view.bounds.height
        
        animatedView.center = CGPoint(x: currentX + newPosition.x, y: currentY + newPosition.y)
        animator.fractionComplete = animatedView.frame.origin.y / final
        panGesture.setTranslation(.zero, in: self.view)
    }
}
