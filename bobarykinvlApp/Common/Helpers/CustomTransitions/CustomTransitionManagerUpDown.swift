//
//  CustomTransitionManagerUpDown.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 28.12.22.
//

import UIKit

enum CustomTransitionType: Int {
    case CustomTransitionManagerUpDown = 1
    case CustomTransitionManagerEdge
    case CustomTransitionManagerRotate
    case CustomTransitionManagerFlip
    case customTransitionManagerFlipOut
    case customTransitionManagerRotateX
}

protocol CustomTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var isPresented: Bool { get set }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?)
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
}

final class CustomTransitionManagerUpDown: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresented = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.viewController(forKey: .to)?.view,
              let fromView = transitionContext.viewController(forKey: .from)?.view else { return }
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        let beginState = CGAffineTransform(translationX: 0, y: containerView.frame.height)
        let endState = CGAffineTransform(translationX: 0, y: -containerView.frame.height)
        
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

extension CustomTransitionManagerUpDown: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
}
