//
//  TransitionManagerCoordinator.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 30.01.23.
//

import Foundation
import UIKit

final class TransitionManagerCoordinator {
    
    let customTransitionManagerUpDown = CustomTransitionManagerUpDown()
    private let customTransitionManagerEdge = CustomTransitionManagerEdge()
    private let customTransitionManagerRotate = CustomTransitionManagerRotate()
    private let customTransitionManagerFlip = CustomTransitionManagerFlip()
    private let customTransitionManagerFlipOut = CustomTransitionManagerFlipOut()
    private let customTransitionManagerRotateX = CustomTransitionManagerRotateX()
    
    func getTransitionManager(animationTransitionType: Int32) -> UIViewControllerAnimatedTransitioning? {
        switch animationTransitionType {
        case 1:
            if customTransitionManagerUpDown.isPresented {
                customTransitionManagerUpDown.isPresented = false
                return customTransitionManagerUpDown
            }
            customTransitionManagerUpDown.isPresented = true
            return customTransitionManagerUpDown
        case 2:
            if customTransitionManagerEdge.isPresented {
                customTransitionManagerEdge.isPresented = false
                return customTransitionManagerEdge
            }
            customTransitionManagerEdge.isPresented = true
            return customTransitionManagerEdge
        case 3:
            if customTransitionManagerRotate.isPresented {
                customTransitionManagerRotate.isPresented = false
                return customTransitionManagerRotate
            }
            customTransitionManagerRotate.isPresented = true
            return customTransitionManagerRotate
        case 4:
            return customTransitionManagerFlip
        case 5:
            return customTransitionManagerFlipOut
        case 6:
            return customTransitionManagerRotateX
        default:
            return nil
        }
    }

    func getSegueId(animationTransitionType: Int32) -> String {
        switch animationTransitionType {
        case 1:
            return AnimationSegueIdentifier.firstAnimationSegue.rawValue
        case 2:
            return AnimationSegueIdentifier.secondAnimationSegue.rawValue
        case 3:
            return AnimationSegueIdentifier.thirdAnimationSegue.rawValue
        case 4:
            return AnimationSegueIdentifier.fourthAnimationSegue.rawValue
        case 5:
            return AnimationSegueIdentifier.fifthAnimationSegue.rawValue
        case 6:
            return AnimationSegueIdentifier.sixthAnimationSegue.rawValue
        default:
            return AnimationSegueIdentifier.firstAnimationSegue.rawValue
        }
    }
}
