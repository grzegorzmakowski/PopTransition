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

protocol PopTransitionAnimatorProtocol: UIViewControllerAnimatedTransitioning {
    var to: UIViewController? { get set }
    var from: UIViewController? { get set }
    var popContainer: UIViewController? { get set }
    var direction: AnimationDirection { get set }
}

extension PopTransitionAnimatorProtocol {
    
    func prepareTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let to = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        guard let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
        
        switch direction {
        case .show:
            self.to = to
            self.from = from
            addPopContainer(to: to, transitionContext: transitionContext)
        case .hide:
            self.to = to
            self.from = from
        }
    }
    
    func addPopContainer(to: UIViewController, transitionContext: UIViewControllerContextTransitioning) {
        let popContainer = UIViewController()
        popContainer.view.backgroundColor = .clear
        popContainer.view.frame = to.view.frame
        
        to.view.translatesAutoresizingMaskIntoConstraints = false
        popContainer.view.addSubview(to.view)
        transitionContext.containerView.addSubview(popContainer.view)
        
        let topPriority = to.view.topAnchor.constraint(greaterThanOrEqualTo: popContainer.view.topAnchor, constant: 44)
        topPriority.priority = UILayoutPriority.defaultHigh
        topPriority.isActive = true
        
        
        let centerPriority = to.view.centerYAnchor.constraint(equalTo: popContainer.view.centerYAnchor)
        centerPriority.priority = UILayoutPriority.required
        centerPriority.isActive = true
        
        let bottomPriority = to.view.bottomAnchor.constraint(greaterThanOrEqualTo: popContainer.view.bottomAnchor, constant: -44)
        bottomPriority.priority = .defaultHigh
        bottomPriority.isActive = true
        to.view.leadingAnchor.constraint(equalTo: popContainer.view.leadingAnchor, constant: 20).isActive = true
        to.view.trailingAnchor.constraint(equalTo: popContainer.view.trailingAnchor, constant: -20).isActive = true
        self.popContainer = popContainer
    }
}

class BasePopTransitionAnimator: NSObject, PopTransitionAnimatorProtocol {
    
    // MARK: - Properties
    
    var popContainer: UIViewController?
    var to: UIViewController?
    var from: UIViewController?
    var direction: AnimationDirection
    
    // MARK: - Initialization
    
    init(direction: AnimationDirection) {
        self.direction = direction
        super.init()
    }
    
    internal func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        prepareTransition(using: transitionContext)
    }
}
