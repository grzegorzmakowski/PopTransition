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
    
    var to: UIViewController?
    var from: UIViewController?
    lazy var popContainer: UIView = { return UIView() }()
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
        popContainer.backgroundColor = .clear
        popContainer.frame = to.view.frame
        to.view.translatesAutoresizingMaskIntoConstraints = false
        
        transitionContext.containerView.addSubview(popContainer)
        popContainer.constraintAllEdges(to: transitionContext.containerView, with: .zero)
        popContainer.addSubview(to.view)
        
        // MARK: - PresentedController constraints
        
        let minimumContentHeight = to.preferredContentSize.height == 0 ? 150 : to.preferredContentSize.height
        let presentedHeightConstraint: NSLayoutConstraint
        if to.preferredContentSize.height > 0 {
            presentedHeightConstraint = to.view.heightAnchor.constraint(equalToConstant: minimumContentHeight)
        } else {
            presentedHeightConstraint = to.view.heightAnchor.constraint(greaterThanOrEqualToConstant: minimumContentHeight)
        }
        
        popContainer.addSubview(to.view)
        to.view.activate([
            to.view.topAnchor.constraint(equalTo: popContainer.topAnchor, constant: 50).with(priority: .defaultHigh),
            to.view.bottomAnchor.constraint(equalTo: popContainer.bottomAnchor, constant: -50).with(priority: .defaultHigh),
            to.view.leadingAnchor.constraint(greaterThanOrEqualTo: popContainer.leadingAnchor, constant: 20).with(priority: .required),
            to.view.trailingAnchor.constraint(lessThanOrEqualTo: popContainer.trailingAnchor, constant: -20).with(priority: .required),
            to.view.centerYAnchor.constraint(equalTo: popContainer.centerYAnchor).with(priority: .required),
            to.view.centerXAnchor.constraint(equalTo: popContainer.centerXAnchor).with(priority: .required),
            presentedHeightConstraint
        ])

        let presentedWidthConstraint = to.view.widthAnchor.constraint(equalToConstant: to.preferredContentSize.width).with(priority: .defaultHigh)
        presentedWidthConstraint.isActive = to.preferredContentSize.width > 0
    }
}
