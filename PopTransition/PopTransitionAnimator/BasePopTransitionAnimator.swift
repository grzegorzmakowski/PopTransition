//
//  PopTransitionAnimator.swift
//  PopTransition
//
//  Created by X349471 on 16/04/2019.
//  Copyright © 2019 X349471. All rights reserved.
//

import Foundation
import UIKit

internal enum PopAnimationDirection {
    case show
    case hide
}

protocol PopTransitionAnimatorProtocol: UIViewControllerAnimatedTransitioning {
    var to: UIViewController? { get set }
    var from: UIViewController? { get set }
    var popContainer: UIViewController? { get set }
    var direction: PopAnimationDirection { get set }
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
        
        transitionContext.containerView.addSubview(popContainer.view)
        popContainer.view.topAnchor.constraint(equalTo: transitionContext.containerView.topAnchor).isActive = true
        popContainer.view.bottomAnchor.constraint(equalTo: transitionContext.containerView.bottomAnchor).isActive = true
        popContainer.view.leftAnchor.constraint(equalTo: transitionContext.containerView.leftAnchor).isActive = true
        popContainer.view.rightAnchor.constraint(equalTo: transitionContext.containerView.rightAnchor).isActive = true

        popContainer.view.addSubview(to.view)
        let center = to.view.centerYAnchor.constraint(equalTo: popContainer.view.centerYAnchor)
        center.priority = .required
        center.isActive = true
        let top = to.view.topAnchor.constraint(equalTo: popContainer.view.topAnchor, constant: 50)
        top.priority = .defaultLow
        top.isActive = true
        let bottom = to.view.bottomAnchor.constraint(equalTo: popContainer.view.bottomAnchor, constant: -50)
        bottom.priority = .defaultLow
        bottom.isActive = true
        let heigh = to.view.heightAnchor.constraint(greaterThanOrEqualToConstant: 150)
        heigh.priority = .required
        heigh.isActive = true
        to.view.leftAnchor.constraint(equalTo: popContainer.view.leftAnchor, constant: 20).isActive = true
        to.view.rightAnchor.constraint(equalTo: popContainer.view.rightAnchor, constant: -20).isActive = true

        self.popContainer = popContainer
    }
}

class BasePopTransitionAnimator: NSObject, PopTransitionAnimatorProtocol {
    
    // MARK: - Properties
    
    var popContainer: UIViewController?
    var to: UIViewController?
    var from: UIViewController?
    var direction: PopAnimationDirection
    
    // MARK: - Initialization
    
    init(direction: PopAnimationDirection) {
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
