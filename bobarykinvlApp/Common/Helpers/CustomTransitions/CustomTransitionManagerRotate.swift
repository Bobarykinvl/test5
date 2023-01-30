//
//  CustomTransitionManagerRotate.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 10.01.23.
//

import UIKit

final class CustomTransitionManagerRotate: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresented = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.viewController(forKey: .to)?.view,
              let fromView = transitionContext.viewController(forKey: .from)?.view else { return }
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        
        let beginState = CGAffineTransform(rotationAngle: .infinity)
        let endState = CGAffineTransform(rotationAngle: .pi)
        
        toView.transform = isPresented ? beginState : endState
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
                
        UIView.animate(withDuration: duration, animations: { [unowned self] in
            toView.transform = .identity
            fromView.transform = isPresented ? endState : beginState
        })  { isFinished in
            fromView.transform = .identity
            transitionContext.completeTransition(isFinished)
        }
    }
}

extension CustomTransitionManagerRotate: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
}
