//
//  CustomTransitionManagerRotateX.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 30.01.23.
//

import UIKit

final class CustomTransitionManagerRotateX: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.viewController(forKey: .to)?.view,
              let fromView = transitionContext.viewController(forKey: .from)?.view else { return }
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        
        var transform = CATransform3DMakeRotation(.pi, 1,0, 1)
        transform.m34 = -1/1000
        UIView.animate(withDuration: 1, animations: {
            fromView.layer.transform = transform
        }) { isFinished in
            fromView.layer.transform = CATransform3DIdentity
            transitionContext.completeTransition(isFinished)
        }
    }
}

extension CustomTransitionManagerRotateX: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
