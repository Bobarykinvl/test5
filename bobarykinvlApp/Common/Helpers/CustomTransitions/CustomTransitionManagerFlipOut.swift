//
//  CustomTransitionManagerFlipOut.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 30.01.23.
//

import UIKit

final class CustomTransitionManagerFlipOut: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.viewController(forKey: .to)?.view,
              let fromView = transitionContext.viewController(forKey: .from)?.view else { return }
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        let startTransform = CATransform3DMakeTranslation(-fromView.frame.size.width/2, 0, 0)
        toView.alpha = 0.1
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .layoutSubviews, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration:0.1, animations: {
                fromView.layer.transform = startTransform
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration:0.9, animations: {
                fromView.layer.transform = CATransform3DRotate(startTransform, -.pi/2, 0,1,0)
                fromView.layer.transform.m34 = -0.001
                toView.alpha = 1
            })
        }) { isFinished in
            fromView.layer.transform = CATransform3DIdentity
            transitionContext.completeTransition(isFinished)
        }
    }
}

extension CustomTransitionManagerFlipOut: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
