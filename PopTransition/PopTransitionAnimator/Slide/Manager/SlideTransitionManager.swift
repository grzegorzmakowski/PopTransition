//
//  SlideTransitionManager.swift
//  PopTransition
//
//  Created by Grzegorz Makowski on 05/04/2020.
//  Copyright © 2020 X349471. All rights reserved.
//

import UIKit

final class SlideTransitionManager: NSObject, UIViewControllerTransitioningDelegate {
    
    // MARK: - Properties
    
    private var interactor: SlideDismissInteractiveTransition?
    
    // MARK: - Initialization
    
//    init(transitionType: PopTransitionType) {
//        self.transitionType = transitionType
//        super.init()
//    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transitionAnimator = SlidePopTransitionAnimator(direction: .show)
        self.interactor = SlideDismissInteractiveTransition(
            presenting: presenting,
            presented: presented,
            popContainer: transitionAnimator.popContainer
        )
        return transitionAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlidePopTransitionAnimator(direction: .hide)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = BaseTransitionPresentationController(presentedViewController: presented, presenting: source)
        return presentationController
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let interactor = interactor else { return nil }
        return interactor.interactionInProgress ? interactor : nil
    }
}
