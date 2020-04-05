//
//  PopTransitionManager.swift
//  PopTransition
//
//  Created by X349471 on 17/04/2019.
//  Copyright © 2019 X349471. All rights reserved.
//

import UIKit

enum PopTransitionType {
    case zoom
    case bounce(BouncePopTransitionType)
}

final class PopDialogTransitionManager: NSObject, UIViewControllerTransitioningDelegate {
    
    // MARK: - Properties
    
    let transitionType: PopTransitionType
    
    // MARK: - Initialization
    
    init(transitionType: PopTransitionType) {
        self.transitionType = transitionType
        super.init()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch transitionType {
        case .zoom:
            return ZoomPopTransitionAnimator(direction: .show)
        case .bounce(let bounceType):
            return BouncePopTransitionAnimator(direction: .show, bounceTransitionType: bounceType)
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch transitionType {
        case .zoom:
            return ZoomPopTransitionAnimator(direction: .hide)
        case .bounce(let bounceType):
            return BouncePopTransitionAnimator(direction: .hide, bounceTransitionType: bounceType)
        }
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = BaseTransitionPresentationController(presentedViewController: presented, presenting: source)
        return presentationController
    }
}
