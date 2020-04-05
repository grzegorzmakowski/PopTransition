//
//  SlidePopTransitionAnimator.swift
//  PopTransition
//
//  Created by Grzegorz Makowski on 04/04/2020.
//  Copyright © 2020 X349471. All rights reserved.
//

import UIKit

class SlidePopTransitionAnimator: NSObject, PopAnimatorTransitioning {
    
    // MARK: - Properties
    
    var to: UIViewController?
    var from: UIViewController?
    lazy var popContainer: UIViewController = { return UIViewController() }()
    var direction: PopAnimationDirection
    var transitionDuration: Double { return 0.4 }
    
    private var tranform: CGAffineTransform {
        guard let to = to else { return .identity }
        return CGAffineTransform(translationX: 0.0, y: to.view.frame.height)
    }
    
    // MARK: - Initialization
    
    init(direction: PopAnimationDirection) {
        self.direction = direction
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        prepareTransition(using: transitionContext)
        switch direction {
        case .show:
            popContainer.view.transform = tranform
            UIView.animate(
                withDuration: transitionDuration,
                delay: 0.0,
                options: [.curveLinear],
                animations: { [weak self] in
                    self?.popContainer.view.transform = .identity
                },
                completion: { _ in
                    transitionContext.completeTransition(true)
                }
            )
        case .hide:
            UIView.animate(
                withDuration: transitionDuration,
                delay: 0.0,
                options: [.curveEaseIn],
                animations: { [weak self] in
                    guard let self = self else { return }
                    self.from?.view.transform = self.tranform
                    self.from?.view.alpha = 0.0
                },
                completion: { _ in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            )
        }
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
        
        let presentedTopConstraint = to.view.topAnchor.constraint(greaterThanOrEqualTo: popContainer.view.topAnchor, constant: 50)
        presentedTopConstraint.priority = .defaultHigh
        presentedTopConstraint.isActive = true
        
        let presentedBottomConstraint = to.view.bottomAnchor.constraint(equalTo: popContainer.view.bottomAnchor)
        presentedBottomConstraint.priority = .required
        presentedBottomConstraint.isActive = true
        
        let presentedLeftConstraint = to.view.leadingAnchor.constraint(equalTo: popContainer.view.leadingAnchor)
        presentedLeftConstraint.priority = .required
        presentedLeftConstraint.isActive = true
        
        let presentedRightConstraint = to.view.trailingAnchor.constraint(equalTo: popContainer.view.trailingAnchor)
        presentedRightConstraint.priority = .required
        presentedRightConstraint.isActive = true
        
        let presentedHeightConstraint: NSLayoutConstraint
        if to.preferredContentSize.height > 0 {
            presentedHeightConstraint = to.view.heightAnchor.constraint(equalToConstant: minimumContentHeight)
        } else {
            presentedHeightConstraint = to.view.heightAnchor.constraint(greaterThanOrEqualToConstant: minimumContentHeight)
        }
        presentedHeightConstraint.priority = .required
        presentedHeightConstraint.isActive = true
    }
}
