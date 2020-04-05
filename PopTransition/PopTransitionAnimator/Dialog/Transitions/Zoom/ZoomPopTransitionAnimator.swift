//
//  ZoomPopTransitionAnimator.swift
//  PopTransition
//
//  Created by X349471 on 17/04/2019.
//  Copyright © 2019 X349471. All rights reserved.
//

import UIKit

final class ZoomPopTransitionAnimator: PopDialogAnimatorTransition {
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        super.animateTransition(using: transitionContext)
        
        switch direction {
        case .show:
            popContainer.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: transitionDuration,
                           delay: 0.0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0,
                           options: [.curveEaseOut],
                           animations: { [weak self] in
                            self?.popContainer.transform = .identity
                }, completion: { _ in
                    transitionContext.completeTransition(true)
            })
        case .hide:
            UIView.animate(withDuration: transitionDuration,
                           delay: 0.0,
                           options: [.curveEaseIn],
                           animations: { [weak self] in
                            self?.from?.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                            self?.from?.view.alpha = 0.0
                }, completion: { _ in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
}
