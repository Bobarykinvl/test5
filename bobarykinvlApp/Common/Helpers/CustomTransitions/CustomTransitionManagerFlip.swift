//
//  CustomTransitionManager4.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 30.01.23.
//

import UIKit

final class CustomTransitionManagerFlip: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.viewController(forKey: .to)?.view,
              let fromView = transitionContext.viewController(forKey: .from)?.view else { return }
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        
        toView.layer.transform = CATransform3DMakeRotation(-.pi/2, 0, 1, 0)
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .layoutSubviews, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                fromView.layer.transform = CATransform3DMakeRotation(-.pi/2, 0, 1, 0)
                fromView.layer.transform.m34 = -0.001
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                toView.layer.transform = CATransform3DMakeRotation(0, 0, 1, 0)
                toView.layer.transform.m34 = -0.001
            })
        }) { isFinished in
            fromView.layer.transform = CATransform3DIdentity
            toView.layer.transform = CATransform3DIdentity
            transitionContext.completeTransition(isFinished)
        }
    }
}

extension CustomTransitionManagerFlip: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
