//
//  PopTransitionAnimator.swift
//  PopTransition
//
//  Created by X349471 on 16/04/2019.
//  Copyright © 2019 X349471. All rights reserved.
//

import UIKit

class PopDialogAnimatorTransition: NSObject, PopAnimatorTransitioning {
    
    // MARK: - Properties
    
    lazy var popContainer: UIViewController = { return UIViewController() }()
    var to: UIViewController?
    var from: UIViewController?
    var direction: PopAnimationDirection
    
    var transitionDuration: Double { return 0.4 }
    
    // MARK: - Initialization
    
    init(direction: PopAnimationDirection) {
        self.direction = direction
        super.init()
    }
    
    internal func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        prepareTransition(using: transitionContext)
    }
    
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
        popContainer.view.backgroundColor = .clear
        popContainer.view.frame = to.view.frame
        to.view.translatesAutoresizingMaskIntoConstraints = false
        
        transitionContext.containerView.addSubview(popContainer.view)
        popContainer.view.topAnchor.constraint(equalTo: transitionContext.containerView.topAnchor).isActive = true
        popContainer.view.bottomAnchor.constraint(equalTo: transitionContext.containerView.bottomAnchor).isActive = true
        popContainer.view.leftAnchor.constraint(equalTo: transitionContext.containerView.leftAnchor).isActive = true
        popContainer.view.rightAnchor.constraint(equalTo: transitionContext.containerView.rightAnchor).isActive = true

        popContainer.view.addSubview(to.view)
        
        let minimumContentHeight = to.preferredContentSize.height == 0 ? 150 : to.preferredContentSize.height
    
        // MARK: - PresentedController constraints
        
        let presentedTopConstraint = to.view.topAnchor.constraint(equalTo: popContainer.view.topAnchor, constant: 50)
        presentedTopConstraint.priority = .defaultHigh
        presentedTopConstraint.isActive = true
        
        let presentedBottomConstraint = to.view.bottomAnchor.constraint(equalTo: popContainer.view.bottomAnchor, constant: -50)
        presentedBottomConstraint.priority = .defaultHigh
        presentedBottomConstraint.isActive = true
        
        let presentedLeftConstraint = to.view.leadingAnchor.constraint(equalTo: popContainer.view.leadingAnchor, constant: 20)
        presentedLeftConstraint.priority = .defaultHigh
        presentedLeftConstraint.isActive = true
        
        let presentedRightConstraint = to.view.trailingAnchor.constraint(equalTo: popContainer.view.trailingAnchor, constant: -20)
        presentedRightConstraint.priority = .defaultHigh
        presentedRightConstraint.isActive = true
        
        let presentedHeightConstraint: NSLayoutConstraint
        if to.preferredContentSize.height > 0 {
            presentedHeightConstraint = to.view.heightAnchor.constraint(equalToConstant: minimumContentHeight)
        } else {
            presentedHeightConstraint = to.view.heightAnchor.constraint(greaterThanOrEqualToConstant: minimumContentHeight)
        }
        presentedHeightConstraint.priority = .required
        presentedHeightConstraint.isActive = true
        
        let presentedWidthConstraint = to.view.widthAnchor.constraint(equalToConstant: to.preferredContentSize.width)
        presentedWidthConstraint.priority = .required
        presentedWidthConstraint.isActive = to.preferredContentSize.width > 0
        
        let presentedCenterYConstraint = to.view.centerYAnchor.constraint(equalTo: popContainer.view.centerYAnchor)
        presentedCenterYConstraint.priority = .required
        presentedCenterYConstraint.isActive = true
        
        let presentedCenterXConstraint = to.view.centerXAnchor.constraint(equalTo: popContainer.view.centerXAnchor)
        presentedCenterXConstraint.priority = .required
        presentedCenterXConstraint.isActive = to.preferredContentSize.width > 0
    }
}
