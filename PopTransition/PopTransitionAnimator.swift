//
//  PopTransitionAnimator.swift
//  PopTransition
//
//  Created by X349471 on 16/04/2019.
//  Copyright © 2019 X349471. All rights reserved.
//

import Foundation
import UIKit

internal enum AnimationDirection {
    case show
    case hide
}

internal class PopTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var to: UIViewController!
    var from: UIViewController!
    let direction: AnimationDirection
    
    init(direction: AnimationDirection) {
        self.direction = direction
        super.init()
    }
    
    internal func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    internal func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch direction {
        case .show:
            guard let to = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
                let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
            
            self.to = to
            self.from = from
            
            let contener = UIViewController()
            contener.view.backgroundColor = .clear
            contener.view.frame = to.view.frame
            
            contener.view.addSubview(to.view)
            
            let container = transitionContext.containerView
            container.addSubview(contener.view)
            
            to.view.translatesAutoresizingMaskIntoConstraints = false
//            to.view.heightAnchor.constraint(equalToConstant: 200).isActive = true
            let topPriority = to.view.topAnchor.constraint(greaterThanOrEqualTo: contener.view.topAnchor, constant: 44)
            topPriority.priority = UILayoutPriority.defaultHigh
            topPriority.isActive = true
            
            
            let centerPriority = to.view.centerYAnchor.constraint(equalTo: contener.view.centerYAnchor)
            centerPriority.priority = UILayoutPriority.required
            centerPriority.isActive = true
            
            let bottomPriority = to.view.bottomAnchor.constraint(greaterThanOrEqualTo: contener.view.bottomAnchor, constant: -44)
            bottomPriority.priority = .defaultHigh
            bottomPriority.isActive = true
            to.view.leadingAnchor.constraint(equalTo: contener.view.leadingAnchor, constant: 40).isActive = true
            to.view.trailingAnchor.constraint(equalTo: contener.view.trailingAnchor, constant: -40).isActive = true
            
            contener.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.curveEaseOut], animations: { [weak self] in
                guard let self = self else { return }
                contener.view.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: { _ in
                    transitionContext.completeTransition(true)
            })
        case .hide:
            guard let to = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
                let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
            
            self.to = to
            self.from = from
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseIn], animations: { [weak self] in
                guard let self = self else { return }
                self.from.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.from.view.alpha = 0.0
                }, completion: { _ in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
}
