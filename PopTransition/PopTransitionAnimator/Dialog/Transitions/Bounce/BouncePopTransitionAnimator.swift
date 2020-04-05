//
//  BouncePopTransitionAnimator.swift
//  PopTransition
//
//  Created by X349471 on 17/04/2019.
//  Copyright © 2019 X349471. All rights reserved.
//

import UIKit

enum BouncePopTransitionType {
    case up
    case down
    case left
    case right
}

final class BouncePopTransitionAnimator: PopDialogAnimatorTransition {
    
    // MARK: - Properties
    
    private let bounceTransitionType: BouncePopTransitionType
    
    private var tranform: CGAffineTransform {
        guard let to = to else { return .identity }
        switch bounceTransitionType {
        case .up:
            return CGAffineTransform(translationX: 0.0, y: -to.view.frame.height)
        case .down:
            return CGAffineTransform(translationX: 0.0, y: to.view.frame.height)
        case .left:
            return CGAffineTransform(translationX: -to.view.frame.width, y: 0.0)
        case .right:
            return CGAffineTransform(translationX: to.view.frame.width, y: 0.0)
        }
    }
    
    // MARK: - Initialization
    
    init(direction: PopAnimationDirection, bounceTransitionType: BouncePopTransitionType) {
        self.bounceTransitionType = bounceTransitionType
        super.init(direction: direction)
    }
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        super.animateTransition(using: transitionContext)
        
        switch direction {
        case .show:
            popContainer.view.transform = tranform
            UIView.animate(withDuration: transitionDuration,
                           delay: 0.0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0,
                           options: [.curveEaseOut],
                           animations: { [weak self] in
                            self?.popContainer.view.transform = .identity
                }, completion: { _ in
                    transitionContext.completeTransition(true)
            })
        case .hide:
            UIView.animate(withDuration: transitionDuration,
                           delay: 0.0,
                           options: [.curveEaseIn],
                           animations: { [weak self] in
                            guard let self = self else { return }
                            self.from?.view.transform = self.tranform
                            self.from?.view.alpha = 0.0
                }, completion: { _ in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
}
